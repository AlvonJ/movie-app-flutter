import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie_app/models/movie.dart';

class MovieServices {
  Future<Movie?> getMovieData(int id) async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/movie/$id?api_key=68534b10080fedd6cb01a2a10681f045&language=en-US');

      Movie movie = Movie.fromJson(result.data);

      return movie;
    } on DioError catch (e) {
      log(e.response.toString());
      return null;
    }
  }

  Future<List<Movie>?> getListMovieData(int pageNumber) async {
    Dio dio = Dio();

    try {
      var result = await dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=68534b10080fedd6cb01a2a10681f045&language=en-US&page=$pageNumber');

      List<Movie> movies = (result.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();

      return movies.take(15).toList();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
