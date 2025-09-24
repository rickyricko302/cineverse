import 'dart:async';
import 'dart:io';

import 'package:netxlif/features/movie/data/datasources/movie_remote_datasource.dart';
import 'package:netxlif/features/movie/data/models/credit_model.dart';
import 'package:netxlif/features/movie/data/models/trailer_model.dart';
import 'package:netxlif/features/movie/domain/entities/cast_entity.dart';
import 'package:netxlif/features/movie/domain/entities/discover_entity.dart';
import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:netxlif/features/movie/domain/entities/search_entity.dart';
import 'package:netxlif/features/movie/domain/entities/trailer_entity.dart';
import 'package:netxlif/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/exception.dart';
import '../../domain/entities/genre_entity.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource movieRemoteDatasource;

  MovieRepositoryImpl({required this.movieRemoteDatasource});

  @override
  Future<List<GenreEntity>> getGenres() async {
    try {
      final response = await movieRemoteDatasource.getGenres();
      if (response.genres == null || response.genres!.isEmpty) {
        return [];
      }
      return response.genres!
          .map(
            (genre) =>
                GenreEntity(id: genre.id ?? 0, name: genre.name ?? 'Unknown'),
          )
          .toList();
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch genres: $e');
    }
  }

  @override
  Future<List<MovieEntity>> getNowPlayingMovies() async {
    try {
      // Simulated error for testing
      final response = await movieRemoteDatasource.getNowPlayingMovies();
      if (response.results == null || response.results!.isEmpty) {
        return [];
      }
      return response.results!.map((movie) {
        return MovieEntity(
          id: movie.id ?? 0,
          title: movie.title ?? '-',
          overview: movie.overview ?? '-',
          backdropPath: movie.backdropPath ?? '-',
          posterPath: movie.posterPath ?? '-',
          voteAverage: movie.voteAverage?.toDouble() ?? 0.0,
          voteCount: movie.voteCount ?? 0,
          popularity: movie.popularity?.toDouble() ?? 0.0,
          releaseDate: movie.releaseDate ?? '-',
          genres: [], // Genres can be fetched separately if needed
        );
      }).toList();
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch now playing movies: $e');
    }
  }

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    try {
      final response = await movieRemoteDatasource.getPopularMovies();
      if (response.results == null || response.results!.isEmpty) {
        return [];
      }
      return response.results!.map((movie) {
        return MovieEntity(
          id: movie.id ?? 0,
          posterPath: movie.posterPath ?? '-',
          title: movie.title ?? '-',
          overview: movie.overview ?? '-',
          backdropPath: movie.backdropPath ?? '-',
          voteAverage: movie.voteAverage?.toDouble() ?? 0.0,
          voteCount: movie.voteCount ?? 0,
          popularity: movie.popularity?.toDouble() ?? 0.0,
          releaseDate: movie.releaseDate ?? '-',
          genres: [], // Genres can be fetched separately if needed
        );
      }).toList();
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch popular movies: $e');
    }
  }

  @override
  Future<List<MovieEntity>> getUpcomingMovies() async {
    try {
      final response = await movieRemoteDatasource.getUpcomingMovies();
      if (response.results == null || response.results!.isEmpty) {
        return [];
      }
      return response.results!.map((movie) {
        return MovieEntity(
          id: movie.id ?? 0,
          posterPath: movie.posterPath ?? '-',
          title: movie.title ?? '-',
          overview: movie.overview ?? '-',
          backdropPath: movie.backdropPath ?? '-',
          voteAverage: movie.voteAverage?.toDouble() ?? 0.0,
          voteCount: movie.voteCount ?? 0,
          popularity: movie.popularity?.toDouble() ?? 0.0,
          releaseDate: movie.releaseDate ?? '-',
          genres: [], // Genres can be fetched separately if needed
        );
      }).toList();
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch upcoming movies: $e');
    }
  }

  @override
  Future<MovieEntity> getMovieDetails({required int movieId}) async {
    try {
      final response = await movieRemoteDatasource.getDetailMovies(
        movieId: movieId,
      );
      List<GenreEntity> genres = [];
      if (response.genres != null && response.genres!.isNotEmpty) {
        genres = response.genres!.map((genre) {
          return GenreEntity(id: genre.id ?? 0, name: genre.name ?? 'Unknown');
        }).toList();
      }
      return MovieEntity(
        id: response.id ?? 0,
        title: response.title ?? 'Unknown',
        backdropPath: response.backdropPath ?? '',
        posterPath: response.posterPath ?? '',
        overview: response.overview ?? 'No overview available',
        releaseDate: response.releaseDate ?? 'Unknown',
        voteAverage: response.voteAverage ?? 0.0,
        voteCount: response.voteCount ?? 0,
        popularity: response.popularity ?? 0.0,
        genres: genres,
      );
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch movie details: $e');
    }
  }

  @override
  Future<List<CastEntity>> getMovieCredits({required int movieId}) async {
    try {
      final CreditModel response = await movieRemoteDatasource.getCreditMovies(
        movieId: movieId,
      );
      if (response.cast == null || response.cast!.isEmpty) {
        return [];
      }
      final List<CastEntity> credits = response.cast!.map((cast) {
        return CastEntity(
          id: cast.id ?? 0,
          name: cast.originalName ?? 'Unknown',
          character: cast.character ?? 'Unknown',
          profilePath: cast.profilePath ?? '',
        );
      }).toList();
      return credits;
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch movie credits: $e');
    }
  }

  @override
  FutureOr<TrailerEntity?> getTrailerMovie({required int movieId}) async {
    try {
      final TrailerModel response = await movieRemoteDatasource
          .getTrailerMovies(movieId: movieId);
      if (response.results == null || response.results!.isEmpty) {
        return null;
      }

      final trailer = response.results!.firstWhere(
        (video) => video.type == 'Trailer',
        orElse: () => response.results!.first,
      );

      return TrailerEntity(
        title: trailer.name ?? '-',
        videoId: trailer.key ?? '-',
        releaseDate: trailer.publishedAt ?? '-',
      );
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch trailer movies: $e');
    }
  }

  @override
  Future<SearchEntity> searchMovies({
    required String query,
    required int page,
  }) async {
    try {
      final response = await movieRemoteDatasource.getSearchMovies(
        query: query,
        page: page,
      );
      if (response.results == null || response.results!.isEmpty) {
        return SearchEntity(results: [], page: 1, totalPages: 1);
      }
      final List<MovieEntity> searchResults = response.results!.map((result) {
        return MovieEntity(
          id: result.id ?? 0,
          title: result.title ?? '-',
          posterPath: result.posterPath ?? '',
          backdropPath: result.backdropPath ?? '',
          overview: result.overview ?? '',
          voteAverage: result.voteAverage?.toDouble() ?? 0.0,
          voteCount: result.voteCount ?? 0,
          popularity: result.popularity?.toDouble() ?? 0.0,
          releaseDate: result.releaseDate ?? '-',
          genres: [], // Genres can be fetched separately if needed
        );
      }).toList();
      return SearchEntity(
        page: response.page ?? 1,
        results: searchResults,
        totalPages: response.totalPages ?? 1,
      );
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch search movies: $e');
    }
  }

  @override
  Future<DiscoverEntity> discoverMovies({
    required List<int> genreIds,
    required int page,
  }) async {
    try {
      final response = await movieRemoteDatasource.getDiscoverMovies(
        genreIds: genreIds,
        page: page,
      );
      List<MovieEntity> movies = response.results!.map((movie) {
        return MovieEntity(
          id: movie.id ?? 0,
          posterPath: movie.posterPath ?? '-',
          title: movie.title ?? '-',
          overview: movie.overview ?? '-',
          backdropPath: movie.backdropPath ?? '-',
          voteAverage: movie.voteAverage?.toDouble() ?? 0.0,
          voteCount: movie.voteCount ?? 0,
          popularity: movie.popularity?.toDouble() ?? 0.0,
          releaseDate: movie.releaseDate ?? '-',
          genres: [], // Genres can be fetched separately if needed
        );
      }).toList();
      return DiscoverEntity(
        page: response.page ?? 1,
        results: movies,
        totalPages: response.totalPages ?? 1,
      );
    } on SocketException {
      throw NetworkException('No Internet connection');
    } catch (e) {
      throw ServerException('Failed to fetch discover movies: $e');
    }
  }
}
