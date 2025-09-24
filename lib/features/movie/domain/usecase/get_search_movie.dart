import 'package:netxlif/features/movie/domain/entities/search_entity.dart';

import '../repositories/movie_repository.dart';

class GetSearchMovieUseCase {
  final MovieRepository movieRepository;

  GetSearchMovieUseCase({required this.movieRepository});

  Future<SearchEntity> call({required String query, required int page}) async {
    return await movieRepository.searchMovies(query: query, page: page);
  }
}
