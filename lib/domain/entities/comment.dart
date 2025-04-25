import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(String id, Map<String, dynamic> json) {
    return Comment(
      id: id,
      userId: json['userId'] ?? '',
      content: json['content'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'content': content,
    'createdAt': Timestamp.fromDate(createdAt),
  };
}
