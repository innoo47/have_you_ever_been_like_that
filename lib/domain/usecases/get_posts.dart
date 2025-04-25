import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Stream<List<Post>> call(String questionId) {
    return repository.getPosts(questionId);
  }
}
