import 'package:bloc_rxdart/src/domain/repositories/movie_repository.dart';
import 'package:bloc_rxdart/src/presentation/blocs/movie/movie_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/enum/enums.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late MovieBloc movieBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBloc = GetIt.I<MovieBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie List"),
      ),
      body: BlocProvider(
          create: (_) => movieBloc..add(MoviesFetch()),
          child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            switch (state.moviesList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(
                  child: Text(state.moviesList.message.toString()),
                );
              case Status.completed:
                if (state.moviesList.data == null) {
                  return const Center(child: Text("No Data"));
                }
                final movieList = state.moviesList.data!;
                return ListView.builder(
                  itemCount: movieList.tvShow.length,
                  itemBuilder: (context, index) {
                    final tvShow = movieList.tvShow[index];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 50, // Đặt chiều rộng cụ thể
                          height: 50, // Đặt chiều cao cụ thể
                          child: CachedNetworkImage(
                            imageUrl: tvShow.imageThumbnailPath,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(), // Thêm placeholder
                          ),
                        ),
                        title: Text(tvShow.name.toString()),
                        subtitle: Text(tvShow.network.toString()),
                        trailing: Text(tvShow.status.toString()),
                      ),
                    );
                  },
                );

              default:
                return SizedBox();
            }
          })),
    );
  }
}
