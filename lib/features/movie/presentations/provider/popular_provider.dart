import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_provider.g.dart';

@riverpod
FutureOr<List<MovieEntity>> popularMovie(Ref ref) async {
  final getPopularMovieUseCase = ref.watch(getPopularMovieUseCaseProvider);
  return await getPopularMovieUseCase();
}
