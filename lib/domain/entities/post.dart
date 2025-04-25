import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String userId;
  final String emotion;
  final String content;
  final DateTime createdAt;
  final int likes;

  Post({
    required this.id,
    required this.userId,
    required this.emotion,
    required this.content,
    required this.createdAt,
    required this.likes,
  });

  factory Post.fromJson(String id, Map<String, dynamic> json) {
    return Post(
      id: id,
      userId: json['userId'] ?? '',
      emotion: json['emotion'] ?? '',
      content: json['content'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      likes: json['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'emotion': emotion,
    'content': content,
    'createdAt': Timestamp.fromDate(createdAt),
    'likes': likes,
  };
}
