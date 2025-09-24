import 'package:netxlif/features/movie/domain/entities/genre_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_genre_provider.g.dart';

@riverpod
class SelectedGenre extends _$SelectedGenre {
  @override
  List<GenreEntity> build({required String label}) {
    return [];
  }

  void addGenre(GenreEntity genre) {
    state = [...state, genre];
  }

  void removeGenre(GenreEntity genre) {
    state = state.where((g) => g.id != genre.id).toList();
  }

  void toggle({required GenreEntity genre, required bool isSelected}) {
    if (isSelected) {
      addGenre(genre);
    } else {
      removeGenre(genre);
    }
  }
}
