import 'package:netxlif/features/movie/domain/entities/cast_entity.dart';
import 'package:netxlif/features/movie/domain/repositories/movie_repository.dart';

class GetCreditMovieUseCase {
  final MovieRepository repository;
  GetCreditMovieUseCase({required this.repository});

  Future<List<CastEntity>> call({required int movieId}) async {
    return await repository.getMovieCredits(movieId: movieId);
  }
}
