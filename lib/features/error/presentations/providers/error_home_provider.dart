import 'package:netxlif/features/movie/presentations/provider/now_playing_movie_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../movie/presentations/provider/genre_provider.dart';
import '../../../movie/presentations/provider/popular_provider.dart';
import '../../../movie/presentations/provider/upcoming_provider.dart';

part 'error_home_provider.g.dart';

@riverpod
class ErrorHome extends _$ErrorHome {
  @override
  Future<void> build() async {
    try {
      await _init();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> _init() async {
    final genre = ref.watch(genreProvider.future);
    final nowPlaying = ref.watch(nowPlayingMovieProvider.future);
    final upcoming = ref.watch(upcomingMovieProvider.future);
    final popular = ref.watch(popularMovieProvider.future);

    // Tunggu semua future selesai menggunakan Future.wait
    // Jika salah satu gagal, Future.wait akan langsung melempar error
    await Future.wait([genre, nowPlaying, upcoming, popular]);
  }

  void retryGet() {
    ref.invalidate(genreProvider);
    ref.invalidate(nowPlayingMovieProvider);
    ref.invalidate(upcomingMovieProvider);
    ref.invalidate(popularMovieProvider);
  }
}
