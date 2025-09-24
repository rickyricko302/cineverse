import 'package:netxlif/core/provider/api_service_provider.dart';
import 'package:netxlif/features/movie/domain/usecase/get_credit_movie.dart';
import 'package:netxlif/features/movie/domain/usecase/get_genre_movie.dart';
import 'package:netxlif/features/movie/domain/usecase/get_now_playing_movie.dart';
import 'package:netxlif/features/movie/domain/usecase/get_popular_movie.dart';
import 'package:netxlif/features/movie/domain/usecase/get_trailer_movie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/movie_remote_datasource.dart';
import '../../data/repositories/movie_repository.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/usecase/get_detail_movie.dart';
import '../../domain/usecase/get_discover_movie.dart';
import '../../domain/usecase/get_search_movie.dart';
import '../../domain/usecase/get_upcoming_movie.dart';

part 'movie_injection.g.dart';

@Riverpod(keepAlive: true)
MovieRemoteDatasource movieRemoteDatasource(Ref ref) {
  return MovieRemoteDatasource(apiService: ref.watch(apiServiceProvider));
}

@Riverpod(keepAlive: true)
MovieRepository movieRepository(Ref ref) {
  return MovieRepositoryImpl(
    movieRemoteDatasource: ref.watch(movieRemoteDatasourceProvider),
  );
}

@Riverpod(keepAlive: true)
GetGenreMovieUseCase getGenreMovieUseCase(Ref ref) {
  return GetGenreMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase(Ref ref) {
  return GetNowPlayingMoviesUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetPopularMovieUseCase getPopularMovieUseCase(Ref ref) {
  return GetPopularMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetUpcomingMovieUseCase getUpcomingMovieUseCase(Ref ref) {
  return GetUpcomingMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetDetailMovieUseCase getDetailMovieUseCase(Ref ref) {
  return GetDetailMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetCreditMovieUseCase getCreditMovieUseCase(Ref ref) {
  return GetCreditMovieUseCase(repository: ref.watch(movieRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetTrailerMovieUseCase getTrailerMovieUseCase(Ref ref) {
  return GetTrailerMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetSearchMovieUseCase getSearchMovieUseCase(Ref ref) {
  return GetSearchMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
GetDiscoverMovieUseCase getDiscoverMovieUseCase(Ref ref) {
  return GetDiscoverMovieUseCase(
    movieRepository: ref.watch(movieRepositoryProvider),
  );
}
