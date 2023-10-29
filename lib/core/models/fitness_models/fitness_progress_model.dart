import 'dart:convert';

import 'package:equatable/equatable.dart';

class FitnessProgress extends Equatable {
  final String id;
  final DateTime timestamp;
  final bool breakfast;
  final bool lunch;
  final bool dinner;
  final bool snacks;
  final bool workout;

  const FitnessProgress({
    required this.id,
    required this.timestamp,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
    required this.workout,
  });

  factory FitnessProgress.fallback() {
    return FitnessProgress(
      id: "",
      timestamp: DateTime.now(),
      breakfast: false,
      lunch: false,
      dinner: false,
      snacks: false,
      workout: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'timestamp': timestamp.toIso8601String(),
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snacks': snacks,
      'workout': workout,
    };
  }

  factory FitnessProgress.fromMap(Map<String, dynamic> map) {
    return FitnessProgress(
      id: map['_id'],
      timestamp: map['timestamp'] != null
          ? DateTime.parse(map['timestamp'])
          : DateTime.now(),
      breakfast: map['breakfast'] ?? false,
      lunch: map['lunch'] ?? false,
      dinner: map['dinner'] ?? false,
      snacks: map['snacks'] ?? false,
      workout: map['workout'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FitnessProgress.fromJson(String source) =>
      FitnessProgress.fromMap(json.decode(source));

  FitnessProgress copyWith({
    String? id,
    DateTime? timestamp,
    bool? breakfast,
    bool? lunch,
    bool? dinner,
    bool? snacks,
    bool? workout,
  }) {
    return FitnessProgress(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      breakfast: breakfast ?? this.breakfast,
      lunch: lunch ?? this.lunch,
      dinner: dinner ?? this.dinner,
      snacks: snacks ?? this.snacks,
      workout: workout ?? this.workout,
    );
  }

  double get doneRatio {
    var done = 0;
    if (breakfast) done++;
    if (lunch) done++;
    if (dinner) done++;
    if (snacks) done++;
    if (workout) done++;
    return done / 5;
  }

  @override
  List<Object?> get props => [
        id,
        timestamp,
        breakfast,
        lunch,
        dinner,
        snacks,
        workout,
      ];

  @override
  String toString() {
    return 'FitnessProgress(id: $id, timestamp: $timestamp, breakfast: $breakfast, lunch: $lunch, dinner: $dinner, snacks: $snacks, workout: $workout)';
  }
}
