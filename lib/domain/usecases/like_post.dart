import '../repositories/post_repository.dart';

class LikePost {
  final PostRepository repository;

  LikePost(this.repository);

  Future<void> call(String questionId, String postId) {
    return repository.likePost(questionId, postId);
  }
}
