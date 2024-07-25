import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../blocs/post/post_bloc.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<PostBloc>()..add(const PostEvent.fetch()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return state.when(
              initial: () =>
                  const Center(child: Text('Press button to load posts')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (posts) => ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              ),
              error: (message) => Center(child: Text('Error: $message')),
            );
          },
        ),
      ),
    );
  }
}
