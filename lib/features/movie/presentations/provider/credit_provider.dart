import 'package:netxlif/features/movie/presentations/provider/movie_injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cast_entity.dart';
part 'credit_provider.g.dart';

@riverpod
FutureOr<List<CastEntity>> credit(Ref ref, {required int movieId}) async {
  final getCreditUseCase = ref.watch(getCreditMovieUseCaseProvider);
  return await getCreditUseCase(movieId: movieId);
}
