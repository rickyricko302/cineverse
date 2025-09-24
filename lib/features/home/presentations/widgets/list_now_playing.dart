import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/provider/now_playing_movie_provider.dart';
import 'package:netxlif/shared_widgets/card_movie_big.dart';
import 'package:netxlif/shared_widgets/shimmer_moview_big.dart';

import '../../../../core/theme.dart';

class ListNowPlaying extends ConsumerWidget {
  const ListNowPlaying({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Now Playing', style: textTheme.titleMedium),
          Gap(4),
          SizedBox(
            height: 200,
            child: nowPlayingMovies.when(
              data: (movies) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (context, index) => Gap(20),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return CardMovieBig(
                    movieId: movie.id,
                    backdropPath: movie.backdropPath,
                    posterPath: movie.posterPath,
                    title: movie.title,
                    overview: movie.overview,
                  );
                },
              ),
              error: (error, stack) {
                return Center(
                  child: Text(
                    'Error: $error',
                    style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
                );
              },
              loading: () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (context, index) => Gap(20),
                itemBuilder: (context, index) {
                  return ShimmerMoviewBig();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
