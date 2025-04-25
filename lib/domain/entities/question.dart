import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String text;
  final DateTime date;

  Question({required this.id, required this.text, required this.date});

  factory Question.fromJson(String id, Map<String, dynamic> json) {
    return Question(
      id: id,
      text: json['text'] ?? '',
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'date': Timestamp.fromDate(date),
  };
}
