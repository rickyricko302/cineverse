import 'dart:async';

import 'package:netxlif/features/movie/domain/entities/cast_entity.dart';
import 'package:netxlif/features/movie/domain/entities/discover_entity.dart';
import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';
import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:netxlif/features/movie/domain/entities/search_entity.dart';
import 'package:netxlif/features/movie/domain/entities/trailer_entity.dart';

abstract class MovieRepository {
  Future<List<GenreEntity>> getGenres();
  Future<List<MovieEntity>> getNowPlayingMovies();
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getUpcomingMovies();
  Future<MovieEntity> getMovieDetails({required int movieId});
  Future<List<CastEntity>> getMovieCredits({required int movieId});
  FutureOr<TrailerEntity?> getTrailerMovie({required int movieId});
  Future<SearchEntity> searchMovies({required String query, required int page});
  Future<DiscoverEntity> discoverMovies({
    required List<int> genreIds,
    required int page,
  });
}
