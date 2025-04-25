import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/post.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../../../domain/usecases/get_posts.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/like_post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  final AddPost addPost;
  final LikePost likePost;

  StreamSubscription? _postsSubscription;

  PostBloc({
    required this.getPosts,
    required this.addPost,
    required this.likePost,
  }) : super(PostInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddNewPost>(_onAddPost);
    on<LikePostEvent>(_onLikePost);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) {
    emit(PostLoading());
    _postsSubscription?.cancel();
    _postsSubscription = getPosts(
      event.questionId,
    ).listen((posts) => add(_PostListUpdated(posts)));
  }

  void _onAddPost(AddNewPost event, Emitter<PostState> emit) async {
    try {
      await addPost(event.questionId, event.post);
    } catch (e) {
      emit(PostError("글 추가에 실패했어요"));
    }
  }

  void _onLikePost(LikePostEvent event, Emitter<PostState> emit) async {
    try {
      await likePost(event.questionId, event.postId);
    } catch (e) {
      emit(PostError("공감 처리에 실패했어요"));
    }
  }

  // 내부용 이벤트 (Stream 데이터 받기 위함)
  void _onPostListUpdated(_PostListUpdated event, Emitter<PostState> emit) {
    emit(PostLoaded(event.posts));
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}

// 내부 이벤트 (Stream으로 받은 결과 처리용)
class _PostListUpdated extends PostEvent {
  final List<Post> posts;

  const _PostListUpdated(this.posts);

  @override
  List<Object?> get props => [posts];
}
