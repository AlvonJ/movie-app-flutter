// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  Movie get movie => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  List<String> get seats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call(
      {Movie movie,
      DateTime date,
      String time,
      double price,
      List<String> seats});

  $MovieCopyWith<$Res> get movie;
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
    Object? date = null,
    Object? time = null,
    Object? price = null,
    Object? seats = null,
  }) {
    return _then(_value.copyWith(
      movie: null == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      seats: null == seats
          ? _value.seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res> get movie {
    return $MovieCopyWith<$Res>(_value.movie, (value) {
      return _then(_value.copyWith(movie: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$_TicketCopyWith(_$_Ticket value, $Res Function(_$_Ticket) then) =
      __$$_TicketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Movie movie,
      DateTime date,
      String time,
      double price,
      List<String> seats});

  @override
  $MovieCopyWith<$Res> get movie;
}

/// @nodoc
class __$$_TicketCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$_Ticket>
    implements _$$_TicketCopyWith<$Res> {
  __$$_TicketCopyWithImpl(_$_Ticket _value, $Res Function(_$_Ticket) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
    Object? date = null,
    Object? time = null,
    Object? price = null,
    Object? seats = null,
  }) {
    return _then(_$_Ticket(
      movie: null == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      seats: null == seats
          ? _value._seats
          : seats // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ticket implements _Ticket {
  const _$_Ticket(
      {required this.movie,
      required this.date,
      required this.time,
      required this.price,
      required final List<String> seats})
      : _seats = seats;

  factory _$_Ticket.fromJson(Map<String, dynamic> json) =>
      _$$_TicketFromJson(json);

  @override
  final Movie movie;
  @override
  final DateTime date;
  @override
  final String time;
  @override
  final double price;
  final List<String> _seats;
  @override
  List<String> get seats {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seats);
  }

  @override
  String toString() {
    return 'Ticket(movie: $movie, date: $date, time: $time, price: $price, seats: $seats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ticket &&
            (identical(other.movie, movie) || other.movie == movie) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(other._seats, _seats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, movie, date, time, price,
      const DeepCollectionEquality().hash(_seats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      __$$_TicketCopyWithImpl<_$_Ticket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TicketToJson(
      this,
    );
  }
}

abstract class _Ticket implements Ticket {
  const factory _Ticket(
      {required final Movie movie,
      required final DateTime date,
      required final String time,
      required final double price,
      required final List<String> seats}) = _$_Ticket;

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$_Ticket.fromJson;

  @override
  Movie get movie;
  @override
  DateTime get date;
  @override
  String get time;
  @override
  double get price;
  @override
  List<String> get seats;
  @override
  @JsonKey(ignore: true)
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      throw _privateConstructorUsedError;
}
