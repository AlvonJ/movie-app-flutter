import 'package:movie_app/models/movie.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket(
      {required Movie movie,
      required DateTime date,
      required String time,
      required double price,
      required List<String> seats}) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}
