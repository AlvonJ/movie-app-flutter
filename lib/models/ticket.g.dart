// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ticket _$$_TicketFromJson(Map<String, dynamic> json) => _$_Ticket(
      movie: Movie.fromJson(json['movie'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      price: (json['price'] as num).toDouble(),
      seats: (json['seats'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_TicketToJson(_$_Ticket instance) => <String, dynamic>{
      'movie': instance.movie,
      'date': instance.date.toIso8601String(),
      'time': instance.time,
      'price': instance.price,
      'seats': instance.seats,
    };
