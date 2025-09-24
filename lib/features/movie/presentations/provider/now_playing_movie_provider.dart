import 'package:netxlif/features/movie/domain/entities/movie_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'movie_injection.dart';

part 'now_playing_movie_provider.g.dart';

@riverpod
FutureOr<List<MovieEntity>> nowPlayingMovie(Ref ref) async {
  final getNowPlayingMoviesUseCase = ref.watch(
    getNowPlayingMoviesUseCaseProvider,
  );
  return await getNowPlayingMoviesUseCase();
}
