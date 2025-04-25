import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post.dart';

class PostFirestoreDatasource {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addPost(String questionId, Post post) async {
    await _firestore
        .collection('questions')
        .doc(questionId)
        .collection('posts')
        .add(post.toJson());
  }

  Stream<List<Post>> getPosts(String questionId) {
    return _firestore
        .collection('questions')
        .doc(questionId)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Post.fromJson(doc.id, doc.data()))
              .toList();
        });
  }

  Future<void> likePost(String questionId, String postId) async {
    final postRef = _firestore
        .collection('questions')
        .doc(questionId)
        .collection('posts')
        .doc(postId);

    await postRef.update({'likes': FieldValue.increment(1)});
  }
}
