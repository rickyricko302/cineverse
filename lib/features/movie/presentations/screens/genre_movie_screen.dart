import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netxlif/features/movie/presentations/provider/discover_provider.dart';
import 'package:netxlif/features/movie/presentations/states/discover_state.dart';

import '../../../../shared_widgets/card_movie_big.dart';
import '../../../../shared_widgets/shimmer_moview_big.dart';
import '../provider/selected_genre_provider.dart';

class GenreMovieScreen extends ConsumerWidget {
  const GenreMovieScreen({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGenres = ref.watch(selectedGenreProvider(label: label));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(selectedGenres.map((e) => e.name).join(', ')),
        actions: [
          Consumer(
            builder: (context, localRef, child) {
              return localRef
                  .watch(discoverProvider(selectedGenres: selectedGenres))
                  .when(
                    data: (DiscoverState state) {
                      return DropdownButton(
                        dropdownColor: Colors.black,
                        underline: SizedBox(),
                        value: state.currentPage,
                        icon: Icon(Icons.filter_list, color: Colors.white),
                        items: List.generate(
                          state.totalPages > 100 ? 100 : state.totalPages,
                          (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'Page ${index + 1}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        onChanged: (page) {
                          if (page != null) {
                            localRef
                                .read(
                                  discoverProvider(
                                    selectedGenres: selectedGenres,
                                  ).notifier,
                                )
                                .loadWithPage(page: page);
                          }
                        },
                      );
                    },
                    error: (e, st) {
                      return SizedBox();
                    },
                    loading: () {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      );
                    },
                  );
            },
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Consumer(
          builder: (context, ref, child) {
            return ref
                .watch(discoverProvider(selectedGenres: selectedGenres))
                .when(
                  data: (DiscoverState state) => state.movies.isEmpty
                      ? Center(child: Text('No movies found this genre'))
                      : ListView.separated(
                          padding: EdgeInsets.all(20),
                          itemCount: state.movies.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];
                            return CardMovieBig(
                              movieId: movie.id,
                              backdropPath: movie.backdropPath,
                              posterPath: movie.posterPath,
                              title: movie.title,
                              overview: movie.overview,
                            );
                          },
                        ),
                  error: (error, stack) => Center(
                    child: Text(
                      'Error occurred: $error',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  loading: () => ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) =>
                        ShimmerMoviewBig(width: double.infinity),
                  ),
                );
          },
        ),
      ),
    );
  }
}
