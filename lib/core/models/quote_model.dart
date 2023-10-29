import 'dart:convert';

class QuoteModel {
  final String id;
  final String quote;
  final String author;
  QuoteModel({
    required this.id,
    required this.quote,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      id: map['id'],
      quote: map['quote'],
      author: map['author'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteModel.fromJson(String source) =>
      QuoteModel.fromMap(json.decode(source));
}

final mockQuote = QuoteModel(
  id: '1',
  quote:
      "The question isn't who is going to let me; it's who is going to stop me.",
  author: "Ayn Rand",
);
