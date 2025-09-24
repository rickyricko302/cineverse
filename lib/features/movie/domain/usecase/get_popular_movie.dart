import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';

import '../repositories/movie_repository.dart';

class GetPopularMovieUseCase {
  final MovieRepository movieRepository;

  GetPopularMovieUseCase({required this.movieRepository});

  Future<List<MovieEntity>> call() async {
    return await movieRepository.getPopularMovies();
  }
}
