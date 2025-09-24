import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../features/movie/presentations/screens/detail_movie_screen.dart';

class CardMovieSmall extends StatelessWidget {
  const CardMovieSmall({
    super.key,
    required this.movieId,
    required this.imageUrl,
  });
  final int movieId;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMovieScreen(movieId: movieId),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: 100,
          errorWidget: (context, url, error) => Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
            child: Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
