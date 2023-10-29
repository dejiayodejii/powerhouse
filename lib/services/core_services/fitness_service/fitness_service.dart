import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:powerhouse/app/_app.dart';
import 'package:powerhouse/app/flavors/flavor_config.dart';
import 'package:powerhouse/core/constants/_constants.dart';
import 'package:powerhouse/core/extensions/_extension.dart';
import 'package:powerhouse/core/models/_models.dart';
import 'package:powerhouse/services/_services.dart';
import 'package:uuid/uuid.dart';

class FitnessService extends IFitnessService {
  static const timeout = Duration(seconds: 30);
  final IUserService userService;
  FitnessService({
    required this.userService,
  });

  static const _uuid = Uuid();
  final _firestore = FirebaseFirestore.instance;

  CollectionRef get _userProgressCollection => _firestore
      .collection('users')
      .doc(user.id)
      .collection('fitness_progress');
  CollectionRef get _dailyPlansCollection =>
      _firestore.collection('admin').doc('fitness').collection('plans');

  Future<List<FitnessProgress>> _fetchUserProgress({int days = 30}) async {
    try {
      final data = await _userProgressCollection
          .limit(days)
          .orderBy(FieldPath.fromString("timestamp"), descending: true)
          .get()
          .timeout(timeout);
      if (data.docs.isEmpty) return [FitnessProgress.fallback()];

      final progress =
          data.docs.map((doc) => FitnessProgress.fromMap(doc.data())).toList();
      progress.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return progress;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      throw Failure(message: "Please check your internet connection");
    }
  }

  Future<void> _fillAbsentDays({int days = 30}) async {
    /// Deleting data
    // final data = await _fetchUserProgress();
    // for (var dat in data) {
    //   if (dat.timestamp.hour == 00 && dat.timestamp.minute == 00) {
    //     await _userProgressCollection.doc(dat.id).delete();
    //   }
    // }

    /// Fetch event
    final data = await _fetchUserProgress(days: days);

    /// Get consecutive list of days within that period
    final list = List<DateTime>.generate(days, (index) {
      return data.last.timestamp.daytimeDay.subtract(Duration(days: index));
    });

    /// Check if they exist on firestore
    list.removeWhere((day) =>
        data.map((e) => e.timestamp.daytimeDay).any((date) => date == day));

    /// Add the fallback for the missing days
    await Future.forEach(list, (DateTime date) async {
      var dayProgress = FitnessProgress.fallback();
      dayProgress = dayProgress.copyWith(id: _uuid.v4(), timestamp: date);
      await _userProgressCollection
          .doc(dayProgress.id)
          .set(dayProgress.toMap());
    });
  }

  @override
  Future<FitnessDayPlan> getCurrentDayPlan() async {
    final day = FlavorConfig.isDevelopment() ? 5 : DateTime.now().day;
    final data = await _dailyPlansCollection
        .where(FieldPath.fromString("day"), isEqualTo: day)
        .get();

    if (data.docs.isEmpty) throw Failure(message: 'No daily plan found');
    return FitnessDayPlan.fromMap(data.docs.first.data());
  }

  @override
  Future<List<FitnessProgress>> getMonthProgress() async {
    /// Fetch Data from firestore
    final progress = await _fetchUserProgress(days: 30);
    if (progress.isEmpty) return [FitnessProgress.fallback()];

    final diff = progress.last.timestamp.difference(progress.first.timestamp);
    await _fillAbsentDays(days: diff.inDays);

    /// Check that the last data is the data for the day, else remove the first
    /// data and add a fallback for the current day
    if (!progress.last.timestamp.compareExactDay(DateTime.now())) {
      progress
        ..removeAt(0)
        ..add(FitnessProgress.fallback());
    }

    assert(progress.isNotEmpty);
    return progress;
  }

  @override
  Future<List<FitnessProgress>> getWeeklyProgress() async {
    final days = DateTime.now().weekday;
    await _fillAbsentDays(days: days);
    return await _fetchUserProgress(days: days);
  }

  @override
  Future<FitnessProgress> getCurrentDayProgress() async {
    final _progress = await _userProgressCollection
        .orderBy(FieldPath.fromString("timestamp"), descending: true)
        .limit(1)
        .get();
    if (_progress.docs.isEmpty) {
      return FitnessProgress.fallback();
    } else {
      final data = FitnessProgress.fromMap(_progress.docs.first.data());
      if (data.timestamp.compareExactDay(DateTime.now())) {
        return data;
      }
    }

    /// Set a default for the day
    final data = FitnessProgress.fallback().copyWith(id: _uuid.v4());
    await _userProgressCollection.doc(data.id).set(data.toMap());
    return data;
  }

  @override
  Future<FitnessProgress> updateProgress(FitnessProgress progress) async {
    progress = progress.copyWith(
      timestamp: DateTime.now(),
    );
    await _userProgressCollection.doc(progress.id).set(progress.toMap());
    return progress;
  }

  UserModel get user => userService.currentUser!;
}
