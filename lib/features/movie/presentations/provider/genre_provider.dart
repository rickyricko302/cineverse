import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';
import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'genre_provider.g.dart';

@riverpod
FutureOr<List<GenreEntity>> genre(Ref ref) async {
  final getGenreMovieUseCase = ref.watch(getGenreMovieUseCaseProvider);
  final List<GenreEntity> genreModel = await getGenreMovieUseCase();
  return genreModel;
}
