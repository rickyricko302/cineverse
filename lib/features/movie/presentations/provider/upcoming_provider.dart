import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_provider.g.dart';

@riverpod
FutureOr<List<MovieEntity>> upcomingMovie(Ref ref) async {
  final getUpcomingMovieUseCase = ref.watch(getUpcomingMovieUseCaseProvider);
  return await getUpcomingMovieUseCase();
}
