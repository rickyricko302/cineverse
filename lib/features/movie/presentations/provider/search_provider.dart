import 'package:netxlif/features/movie/presentations/states/search_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'movie_injection.dart';

part 'search_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  FutureOr<SearchState> build({required String query}) async {
    final getSearchUseCase = ref.watch(getSearchMovieUseCaseProvider);
    final movies = await getSearchUseCase(query: query, page: 1);
    return SearchState(
      query: query,
      movies: movies.results,
      currentPage: movies.page,
      totalPages: movies.totalPages,
    );
  }

  Future<void> searchMovies({required String query, required int page}) async {
    state = const AsyncLoading();
    try {
      final getSearchUseCase = ref.watch(getSearchMovieUseCaseProvider);
      final movies = await getSearchUseCase(query: query, page: page);
      state = AsyncData(
        SearchState(
          query: query,
          movies: movies.results,
          currentPage: movies.page,
          totalPages: movies.totalPages,
        ),
      );
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
