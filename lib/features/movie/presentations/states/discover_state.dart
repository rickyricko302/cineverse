import '../../domain/entities/movie_entity.dart';

class DiscoverState {
  final String formattedGenres;
  final List<int> selectedGenreIds;
  final List<MovieEntity> movies;
  final int currentPage;
  final int totalPages;

  DiscoverState({
    required this.selectedGenreIds,
    required this.formattedGenres,
    required this.movies,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  DiscoverState copyWith({
    String? formattedGenres,
    List<MovieEntity>? movies,
    int? currentPage,
    int? totalPages,
  }) {
    return DiscoverState(
      selectedGenreIds: selectedGenreIds,
      formattedGenres: formattedGenres ?? this.formattedGenres,
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
