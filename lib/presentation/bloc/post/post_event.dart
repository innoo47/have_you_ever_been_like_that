import 'package:equatable/equatable.dart';
import '../../../domain/entities/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostEvent {
  final String questionId;

  const LoadPosts(this.questionId);

  @override
  List<Object?> get props => [questionId];
}

class AddNewPost extends PostEvent {
  final String questionId;
  final Post post;

  const AddNewPost(this.questionId, this.post);

  @override
  List<Object?> get props => [questionId, post];
}

class LikePostEvent extends PostEvent {
  final String questionId;
  final String postId;

  const LikePostEvent(this.questionId, this.postId);

  @override
  List<Object?> get props => [questionId, postId];
}
