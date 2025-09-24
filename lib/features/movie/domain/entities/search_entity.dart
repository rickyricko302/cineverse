import 'movie_entity.dart';

class SearchEntity {
  final int page;
  final List<MovieEntity> results;
  final int totalPages;

  SearchEntity({
    required this.page,
    required this.results,
    required this.totalPages,
  });
}
