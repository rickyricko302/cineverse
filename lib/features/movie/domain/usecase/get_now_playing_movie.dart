import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';

import '../repositories/movie_repository.dart';

class GetNowPlayingMoviesUseCase {
  final MovieRepository movieRepository;

  GetNowPlayingMoviesUseCase({required this.movieRepository});

  Future<List<MovieEntity>> call() async {
    return await movieRepository.getNowPlayingMovies();
  }
}
