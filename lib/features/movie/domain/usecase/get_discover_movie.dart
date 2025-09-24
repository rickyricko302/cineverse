import 'package:netxlif/features/movie/domain/entities/discover_entity.dart';

import '../repositories/movie_repository.dart';

class GetDiscoverMovieUseCase {
  final MovieRepository movieRepository;

  GetDiscoverMovieUseCase({required this.movieRepository});

  Future<DiscoverEntity> call({
    required List<int> genreIds,
    required int page,
  }) async {
    return await movieRepository.discoverMovies(genreIds: genreIds, page: page);
  }
}
