import 'dart:convert';

import 'package:intl/intl.dart';

class JournalModel {
  final String? id;
  final String title;
  final String body;
  final int date;

  JournalModel({
    this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  String get parsedDate {
    final date = DateTime.fromMillisecondsSinceEpoch(this.date);
    return DateFormat("dd/MM/yyyy").format(date);
  }

  String get parsedTime {
    final date = DateTime.fromMillisecondsSinceEpoch(this.date);
    return DateFormat("HH:mm").format(date);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JournalModel &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ body.hashCode ^ date.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'date': date,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'],
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      date: map['date']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalModel.fromJson(String source) =>
      JournalModel.fromMap(json.decode(source));

  JournalModel copyWith({
    String? id,
    String? title,
    String? body,
    int? date,
  }) {
    return JournalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
    );
  }
}

final mockJournal = JournalModel(
  id: "1",
  title: "Journal Title",
  body:
      '''This is a sample.. that shook the international community The end of May through June is always a wonderful time, as it's when many Black folks graduate with high school diplomas, as well with undergraduate and advanced degrees. 

It's always great to see our people pursuing their dreams and achieving greatness.

Another added bonus is the number of phenomenal and successful Black women who are invited to give the commencement speech at colleges and universities around the country.

It's always great to see our people pursuing their dreams and achieving greatness.It's always great to see our people pursuing their dreams and achieving greatness.
This is a sample.. that shook the international community The end of May through June is always a wonderful time, as it's when many Black folks graduate with high school diplomas, as well with undergraduate and advanced degrees. 

It's always great to see our people pursuing their dreams and achieving greatness.

Another added bonus is the number of phenomenal and successful Black women who are invited to give the commencement speech at colleges and universities around the country.

It's always great to see our people pursuing their dreams and achieving greatness.It's always great to see our people pursuing their dreams and achieving greatness.''',
  date: DateTime.now().millisecondsSinceEpoch,
);
