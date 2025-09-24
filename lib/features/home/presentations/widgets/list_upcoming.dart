import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/provider/upcoming_provider.dart';
import 'package:netxlif/shared_widgets/card_movie_small.dart';
import 'package:netxlif/shared_widgets/shimmer_movie_small.dart';

import '../../../../core/theme.dart';

class ListUpcoming extends ConsumerWidget {
  const ListUpcoming({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingMovies = ref.watch(upcomingMovieProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upcoming', style: textTheme.titleMedium),
          Gap(4),
          SizedBox(
            height: 150,
            child: upcomingMovies.when(
              data: (movies) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return CardMovieSmall(
                    movieId: movie.id,
                    imageUrl: movie.posterPath,
                  );
                },
                separatorBuilder: (context, index) => Gap(20),
              ),
              error: (error, stackTrace) => Center(
                child: Text(
                  'Error: $error',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
              ),
              loading: () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ShimmerMovieSmall();
                },
                separatorBuilder: (context, index) => Gap(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
