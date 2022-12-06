// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$$_MovieFromJson(Map<String, dynamic> json) => _$_Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] as String,
      poster_path: json['poster_path'] as String,
      runtime: json['runtime'] as int?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vote_average': instance.vote_average,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'runtime': instance.runtime,
      'genres': instance.genres,
    };
