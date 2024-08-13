// combined_screen.dart
import 'package:bloc_rxdart/src/domain/models/album/album_model.dart';
import 'package:bloc_rxdart/src/domain/models/comment/comment_model.dart';
import 'package:bloc_rxdart/src/domain/models/photo/photo.dart';
import 'package:bloc_rxdart/src/domain/models/post/post.dart';
import 'package:bloc_rxdart/src/domain/models/user/user_model.dart';
import 'package:bloc_rxdart/src/presentation/blocs/combined/combined_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CombinedScreen extends StatelessWidget {
  const CombinedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CombinedBloc>().add(const CombinedEvent.fetchDataEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Selections'),
      ),
      body: BlocBuilder<CombinedBloc, CombinedState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("data")),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (
              users,
              photos,
              posts,
              comments,
              albums,
              selectedUser,
              selectedPost,
              selectedComment,
              selectedAlbum,
              selectedPhoto,
            ) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdown<User>(
                      "Select User",
                      users,
                      selectedUser,
                      (user) => user.name,
                      (user) => context
                          .read<CombinedBloc>()
                          .add(CombinedEvent.selectUser(user!)),
                    ),
                    if (selectedUser != null)
                      _buildDropdown<Post>(
                        "Select Post",
                        posts
                            .where((post) => post.userId == selectedUser.id)
                            .toList(),
                        selectedPost,
                        (post) => post.title,
                        (post) => context
                            .read<CombinedBloc>()
                            .add(CombinedEvent.selectPost(post!)),
                      ),
                    if (selectedPost != null)
                      _buildDropdown<CommentModel>(
                        "Select Comment",
                        comments
                            .where(
                                (comment) => comment.postId == selectedPost.id)
                            .toList(),
                        selectedComment,
                        (comment) => comment.name,
                        (comment) => context
                            .read<CombinedBloc>()
                            .add(CombinedEvent.selectComment(comment!)),
                      ),
                    if (selectedUser != null)
                      _buildDropdown<AlbumModel>(
                        "Select Album",
                        albums
                            .where((album) => album.userId == selectedUser.id)
                            .toList(),
                        selectedAlbum,
                        (album) => album.title,
                        (album) => context
                            .read<CombinedBloc>()
                            .add(CombinedEvent.selectAlbum(album!)),
                      ),
                    if (selectedAlbum != null)
                      _buildDropdown<Photo>(
                        "Select Photo",
                        photos
                            .where((photo) => photo.albumId == selectedAlbum.id)
                            .toList(),
                        selectedPhoto,
                        (photo) => photo.title,
                        (photo) => context
                            .read<CombinedBloc>()
                            .add(CombinedEvent.selectPhoto(photo!)),
                      ),
                  ],
                ),
              );
            },
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }

  Widget _buildDropdown<T>(
    String label,
    List<T> items,
    T? selectedItem,
    String Function(T) getLabel,
    void Function(T?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<T>(
          isExpanded: true,
          value: selectedItem,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(getLabel(item)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
