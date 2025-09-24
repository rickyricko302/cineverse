import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/provider/detail_provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/theme.dart';

class Review extends ConsumerWidget {
  const Review({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(detailProvider(movieId: movieId));
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: movie.when(
              data: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: textTheme.bodyLarge),
                  Row(
                    children: [
                      Text(
                        data.voteAverage.toStringAsFixed(1),
                        style: textTheme.titleMedium?.copyWith(
                          color: secondaryColor,
                        ),
                      ),
                      Gap(18),
                      Expanded(
                        child: Row(
                          children: List.generate(10, (index) {
                            return Icon(
                              Icons.star,
                              color: index < data.voteAverage
                                  ? secondaryColor
                                  : Colors.grey,
                              size: 14,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Ratings', style: textTheme.labelLarge),
                      Gap(8),
                      Text(
                        "${data.voteCount.toString()} Reviews",
                        style: textTheme.labelLarge,
                      ),
                    ],
                  ),
                  Gap(4),
                  Text(
                    'Popularity: ${data.popularity}',
                    style: textTheme.labelLarge,
                  ),
                  Gap(4),
                  Text(
                    'Release Date : ${data.releaseDate}',
                    style: textTheme.labelLarge,
                  ),
                ],
              ),
              loading: () => Shimmer(
                duration: const Duration(seconds: 2),
                interval: const Duration(seconds: 0),
                enabled: true,
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Row(
                      spacing: 5,
                      children: [
                        Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
              error: (error, stackTrace) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
