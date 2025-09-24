import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerMovieSmall extends StatelessWidget {
  const ShimmerMovieSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Shimmer(
        duration: Duration(seconds: 2),
        interval: Duration(seconds: 0),
        enabled: true,
        child: Container(
          width: 100,
          decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}
