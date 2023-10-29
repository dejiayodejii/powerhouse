import 'dart:convert';

import 'package:powerhouse/core/extensions/string_extension.dart';

class FitnessDayPlan {
  final String id;
  final int day;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snacks;
  final String workout;

  FitnessDayPlan({
    required this.id,
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
    required this.workout,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'day': day,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snacks': snacks,
      'workout': workout,
    };
  }

  factory FitnessDayPlan.fromMap(Map<String, dynamic> map) {
    return FitnessDayPlan(
      id: map['_id'],
      day: map['day'],
      breakfast: map['breakfast'],
      lunch: map['lunch'],
      dinner: map['dinner'],
      snacks: map['snacks'],
      workout: map['workout'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FitnessDayPlan.fromJson(String source) =>
      FitnessDayPlan.fromMap(json.decode(source));

  List<String> get values {
    final data = toMap();
    data
      ..remove("_id")
      ..remove("day");
    return data.values.toList().cast<String>();
  }

  List<String> get keys {
    final data = toMap();
    data
      ..remove("_id")
      ..remove("day");
    return data.keys.map((e) => e.capitalize()).toList();
  }
}
