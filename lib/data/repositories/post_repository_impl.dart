import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_firestore_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostFirestoreDatasource datasource;

  PostRepositoryImpl(this.datasource);

  @override
  Future<void> addPost(String questionId, Post post) {
    return datasource.addPost(questionId, post);
  }

  @override
  Stream<List<Post>> getPosts(String questionId) {
    return datasource.getPosts(questionId);
  }

  @override
  Future<void> likePost(String questionId, String postId) {
    return datasource.likePost(questionId, postId);
  }
}
