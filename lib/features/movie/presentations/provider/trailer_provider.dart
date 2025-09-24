import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/trailer_entity.dart';
part 'trailer_provider.g.dart';

@riverpod
FutureOr<TrailerEntity?> trailer(Ref ref, {required int movieId}) async {
  final getTrailerUseCase = ref.watch(getTrailerMovieUseCaseProvider);
  return await getTrailerUseCase(movieId: movieId);
}
