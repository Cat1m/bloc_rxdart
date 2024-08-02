import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/photo/photo_bloc.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PhotoBloc>().add(const PhotoEvent.fetch());

    return Scaffold(
      appBar: AppBar(title: const Text('Photos')),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          return state.when(
            initial: () =>
                const Center(child: Text('Press button to load photos')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (photos) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(photo.thumbnailUrl),
                      ),
                      Text(photo.title,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                );
              },
            ),
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }
}
