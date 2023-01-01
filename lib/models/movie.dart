import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie(
      {required int id,
      required String title,
      required double vote_average,
      required String overview,
      required String poster_path,
      int? runtime,
      String? backdrop_path,
      List<Map<String, dynamic>>? genres}) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
