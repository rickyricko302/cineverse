import 'genre_entity.dart';

class MovieEntity {
  final int id;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final String releaseDate;
  final List<GenreEntity>? genres;

  MovieEntity({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genres,
  });
}
