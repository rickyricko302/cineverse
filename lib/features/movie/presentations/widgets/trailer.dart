import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netxlif/features/movie/presentations/provider/trailer_provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailer extends ConsumerWidget {
  const Trailer({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailer = ref.watch(trailerProvider(movieId: movieId));
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: trailer.when(
        data: (data) {
          return Stack(
            alignment: Alignment.center,
            children: [
              YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: data?.videoId ?? '',
                  flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Icon(Icons.error);
        },
        loading: () {
          return Shimmer(
            child: Container(
              width: double.infinity,
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
