import 'package:netxlif/core/network/api_service.dart';
import 'package:netxlif/features/movie/data/models/detail_model.dart';
import 'package:netxlif/features/movie/data/models/discover_model.dart';
import 'package:netxlif/features/movie/data/models/popular_model.dart';
import 'package:netxlif/features/movie/data/models/search_model.dart';
import 'package:netxlif/features/movie/data/models/trailer_model.dart';
import 'package:netxlif/features/movie/data/models/upcoming_model.dart';

import '../models/credit_model.dart';
import '../models/genre_model.dart';
import '../models/now_playing_model.dart';

class MovieRemoteDatasource {
  final ApiService apiService;

  MovieRemoteDatasource({required this.apiService});

  // Mendapatkan daftar genre film dari API
  Future<GenreModel> getGenres() async {
    final response = await apiService.get('/genre/movie/list');
    return GenreModel.fromJson(response);
  }

  // Mendapatkan daftar film yang sedang tayang
  Future<NowPlayingModel> getNowPlayingMovies() async {
    final response = await apiService.get('/movie/now_playing');
    return NowPlayingModel.fromJson(response);
  }

  Future<PopularModel> getPopularMovies() async {
    final response = await apiService.get('/movie/popular');
    return PopularModel.fromJson(response);
  }

  Future<UpcomingModel> getUpcomingMovies() async {
    final response = await apiService.get('/movie/upcoming');
    return UpcomingModel.fromJson(response);
  }

  Future<DetailModel> getDetailMovies({required int movieId}) async {
    final response = await apiService.get('/movie/$movieId?language=en-US');
    return DetailModel.fromJson(response);
  }

  Future<CreditModel> getCreditMovies({required int movieId}) async {
    final response = await apiService.get('/movie/$movieId/credits');
    return CreditModel.fromJson(response);
  }

  Future<TrailerModel> getTrailerMovies({required int movieId}) async {
    final response = await apiService.get('/movie/$movieId/videos');
    return TrailerModel.fromJson(response);
  }

  Future<SearchModel> getSearchMovies({
    required String query,
    required int page,
  }) async {
    final response = await apiService.get(
      '/search/movie?query=$query&page=$page',
    );
    return SearchModel.fromJson(response);
  }

  Future<DiscoverModel> getDiscoverMovies({
    required List<int> genreIds,
    required int page,
  }) async {
    final genreString = genreIds.join(',');
    final response = await apiService.get(
      '/discover/movie?with_genres=$genreString&page=$page',
    );
    return DiscoverModel.fromJson(response);
  }
}
