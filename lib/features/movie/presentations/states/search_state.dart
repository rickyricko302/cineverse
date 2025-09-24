import '../../domain/entities/movie_entity.dart';

class SearchState {
  final String query;
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;

  SearchState({
    required this.query,
    required this.movies,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  SearchState copyWith({
    String? query,
    List<MovieEntity>? movies,
    int? currentPage,
    int? totalPages,
  }) {
    return SearchState(
      query: query ?? this.query,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
