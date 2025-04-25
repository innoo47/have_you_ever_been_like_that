import '../entities/post.dart';

abstract class PostRepository {
  Future<void> addPost(String questionId, Post post);
  Stream<List<Post>> getPosts(String questionId);
  Future<void> likePost(String questionId, String postId);
}
