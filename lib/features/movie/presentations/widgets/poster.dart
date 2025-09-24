import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netxlif/features/movie/presentations/provider/detail_provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Poster extends ConsumerWidget {
  const Poster({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(detailProvider(movieId: movieId));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: movie.when(
        data: (data) {
          final imageUrl = data.posterPath;
          return CachedNetworkImage(
            imageUrl: imageUrl,
            width: 130,
            errorWidget: (context, url, error) => Container(
              width: 130,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              child: Icon(Icons.error, color: Colors.red),
            ),
          );
        },
        error: (error, stackTrace) {
          return const Icon(Icons.error);
        },
        loading: () {
          return Shimmer(
            child: Container(
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
              ),
            ),
          );
        },
      ),
    );
  }
}
