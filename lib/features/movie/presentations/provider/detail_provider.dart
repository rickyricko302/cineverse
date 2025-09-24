import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'detail_provider.g.dart';

@riverpod
FutureOr<MovieEntity> detail(Ref ref, {required int movieId}) async {
  final detailMovieUseCase = ref.watch(getDetailMovieUseCaseProvider);
  return await detailMovieUseCase(movieId: movieId);
}
