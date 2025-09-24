import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';

import '../repositories/movie_repository.dart';

class GetGenreMovieUseCase {
  final MovieRepository movieRepository;

  GetGenreMovieUseCase({required this.movieRepository});

  Future<List<GenreEntity>> call() async {
    return await movieRepository.getGenres();
  }
}
