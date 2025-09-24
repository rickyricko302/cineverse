import 'package:netxlif/features/movie/domain/entities/trailer_entity.dart';
import 'package:netxlif/features/movie/domain/repositories/movie_repository.dart';

class GetTrailerMovieUseCase {
  final MovieRepository movieRepository;

  GetTrailerMovieUseCase({required this.movieRepository});

  Future<TrailerEntity?> call({required int movieId}) async {
    return await movieRepository.getTrailerMovie(movieId: movieId);
  }
}
