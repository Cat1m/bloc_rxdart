// combined_screen.dart
import 'package:bloc_rxdart/src/presentation/blocs/combined/combined_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CombinedScreen extends StatelessWidget {
  const CombinedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CombinedBloc>().add(const CombinedEvent.fetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined list'),
      ),
      body: BlocBuilder<CombinedBloc, CombinedState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (comments, posts, album) {
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];

                  final comment = comments
                      .where((comment) => comment.postId == post.id)
                      .toList();
                  return ExpansionTile(
                    title: Text("tiêu đề: ${post.title}"),
                    children: [
                      Column(
                        children: comment
                            .map((comment) => ListTile(
                                  title: Text(
                                      "Tên Người bình luận: ${comment.name}"),
                                  subtitle: Text(comment.body),
                                ))
                            .toList(),
                      ),
                    ],
                  );
                },
              );
            },
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}
