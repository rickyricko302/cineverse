import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/theme.dart';
import '../features/movie/presentations/screens/detail_movie_screen.dart';

class CardMovieBig extends StatelessWidget {
  const CardMovieBig({
    super.key,
    required this.movieId,
    required this.backdropPath,
    required this.posterPath,
    required this.title,
    required this.overview,
  });
  final int movieId;
  final String backdropPath;
  final String posterPath;
  final String title;
  final String overview;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMovieScreen(movieId: movieId),
        ),
      ),
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(backdropPath),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.black.withValues(alpha: 0.5),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: posterPath,
                    width: 100,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
                Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4),
                      Text(
                        overview,
                        style: textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
