import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:have_you_ever_been_like_that/presentation/bloc/post/post_bloc.dart';
import 'package:have_you_ever_been_like_that/presentation/bloc/post/post_event.dart';
import 'package:have_you_ever_been_like_that/presentation/bloc/post/post_state.dart';
import '../../../domain/entities/post.dart';

class PostFeedScreen extends StatelessWidget {
  final String questionId;

  const PostFeedScreen({super.key, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("오늘의 이야기")),
      body: BlocProvider(
        create:
            (context) => PostBloc(
              getPosts: context.read(),
              addPost: context.read(),
              likePost: context.read(),
            )..add(LoadPosts(questionId)),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return const Center(child: Text("아직 글이 없어요."));
              }

              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return _PostTile(
                    post: post,
                    onLike: () {
                      context.read<PostBloc>().add(
                        LikePostEvent(questionId, post.id),
                      );
                    },
                  );
                },
              );
            }

            if (state is PostError) {
              return Center(child: Text("오류 발생: ${state.message}"));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PostTile extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;

  const _PostTile({required this.post, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.emotion,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(post.content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onLike,
                  icon: const Icon(Icons.favorite_border),
                ),
                Text('${post.likes}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
