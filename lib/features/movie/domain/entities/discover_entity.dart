import 'movie_entity.dart';

class DiscoverEntity {
  final int page;
  final List<MovieEntity> results;
  final int totalPages;

  DiscoverEntity({
    required this.page,
    required this.results,
    required this.totalPages,
  });
}
