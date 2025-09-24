import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';
import 'package:netxlif/features/movie/presentations/states/discover_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'movie_injection.dart';

part 'discover_provider.g.dart';

@riverpod
class Discover extends _$Discover {
  @override
  FutureOr<DiscoverState> build({
    required List<GenreEntity> selectedGenres,
  }) async {
    final getDiscoverUseCase = ref.watch(getDiscoverMovieUseCaseProvider);
    final genreIds = selectedGenres.map((e) => e.id).toList();
    final formattedGenres = selectedGenres.map((e) => e.name).join(', ');
    final response = await getDiscoverUseCase(genreIds: genreIds, page: 1);
    return DiscoverState(
      selectedGenreIds: genreIds,
      formattedGenres: formattedGenres,
      movies: response.results,
      currentPage: 1,
      totalPages: response.totalPages,
    );
  }

  Future<void> loadWithPage({required int page}) async {
    state = const AsyncLoading();
    try {
      final getDiscoverUseCase = ref.watch(getDiscoverMovieUseCaseProvider);
      final response = await getDiscoverUseCase(
        genreIds: state.value!.selectedGenreIds,
        page: page,
      );
      state = AsyncData(
        state.value!.copyWith(movies: response.results, currentPage: page),
      );
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
