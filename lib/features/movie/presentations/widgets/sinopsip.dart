import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/shared_widgets/select_genre_listener.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/theme.dart';
import '../../../../shared_widgets/genre_button.dart';
import '../provider/detail_provider.dart';
import '../provider/selected_genre_provider.dart';

class Sinopsis extends ConsumerWidget {
  const Sinopsis({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(detailProvider(movieId: movieId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Sinopsis', style: textTheme.titleMedium),
        movie.when(
          data: (data) => Column(
            children: [
              Text(data.overview, style: textTheme.bodyMedium),
              Gap(20),
              if (data.genres != null && data.genres!.isNotEmpty) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: data.genres!.map((genre) {
                          return GenreButton(
                            genre: genre,
                            valueChanged: (value) {
                              ref
                                  .read(
                                    selectedGenreProvider(
                                      label: 'movie_$movieId',
                                    ).notifier,
                                  )
                                  .toggle(genre: genre, isSelected: value);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SelectGenreListener(label: 'movie_$movieId'),
                  ],
                ),
              ],
            ],
          ),
          error: (error, stackTrace) =>
              Text(error.toString(), style: textTheme.bodyMedium),
          loading: () => Column(
            spacing: 8,
            children: [
              _buildShimmerLoading(paddingRight: 0),
              _buildShimmerLoading(paddingRight: 20),
              _buildShimmerLoading(paddingRight: 40),
              _buildShimmerLoading(paddingRight: 60),
              _buildShimmerLoading(paddingRight: 40),
              _buildShimmerLoading(paddingRight: 20),
              _buildShimmerLoading(paddingRight: 0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading({required int paddingRight}) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight.toDouble()),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Shimmer(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
