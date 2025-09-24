import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';

import '../repositories/movie_repository.dart';

class GetDetailMovieUseCase {
  final MovieRepository movieRepository;

  GetDetailMovieUseCase({required this.movieRepository});

  Future<MovieEntity> call({required int movieId}) async {
    return await movieRepository.getMovieDetails(movieId: movieId);
  }
}
