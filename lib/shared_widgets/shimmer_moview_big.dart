import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerMoviewBig extends StatelessWidget {
  const ShimmerMoviewBig({super.key, this.width = 300});
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Shimmer(
        duration: Duration(seconds: 2),
        interval: Duration(seconds: 0),
        enabled: true,
        child: Container(
          width: width,
          height: 200,
          decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}
