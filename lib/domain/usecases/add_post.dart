import '../entities/post.dart';
import '../repositories/post_repository.dart';

class AddPost {
  final PostRepository repository;

  AddPost(this.repository);

  Future<void> call(String questionId, Post post) {
    return repository.addPost(questionId, post);
  }
}
