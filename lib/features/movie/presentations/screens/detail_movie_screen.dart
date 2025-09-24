import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:netxlif/features/movie/presentations/widgets/cast.dart';
import 'package:netxlif/features/movie/presentations/widgets/poster.dart';
import 'package:netxlif/features/movie/presentations/widgets/review.dart';
import 'package:netxlif/features/movie/presentations/widgets/sinopsip.dart';
import 'package:netxlif/features/movie/presentations/widgets/trailer.dart';

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({super.key, required this.movieId});
  final int movieId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Trailer(movieId: movieId),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Row(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Poster(movieId: movieId),
                        Review(movieId: movieId),
                      ],
                    ),
                    Gap(20),
                    Sinopsis(movieId: movieId),
                    Gap(20),
                    Cast(movieId: movieId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
