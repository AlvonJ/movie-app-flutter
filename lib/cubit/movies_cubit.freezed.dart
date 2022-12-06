// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'movies_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MoviesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unselected,
    required TResult Function(Movie movie) selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unselected,
    TResult? Function(Movie movie)? selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unselected,
    TResult Function(Movie movie)? selected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unselected value) unselected,
    required TResult Function(_Selected value) selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unselected value)? unselected,
    TResult? Function(_Selected value)? selected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unselected value)? unselected,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviesStateCopyWith<$Res> {
  factory $MoviesStateCopyWith(
          MoviesState value, $Res Function(MoviesState) then) =
      _$MoviesStateCopyWithImpl<$Res, MoviesState>;
}

/// @nodoc
class _$MoviesStateCopyWithImpl<$Res, $Val extends MoviesState>
    implements $MoviesStateCopyWith<$Res> {
  _$MoviesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_UnselectedCopyWith<$Res> {
  factory _$$_UnselectedCopyWith(
          _$_Unselected value, $Res Function(_$_Unselected) then) =
      __$$_UnselectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnselectedCopyWithImpl<$Res>
    extends _$MoviesStateCopyWithImpl<$Res, _$_Unselected>
    implements _$$_UnselectedCopyWith<$Res> {
  __$$_UnselectedCopyWithImpl(
      _$_Unselected _value, $Res Function(_$_Unselected) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Unselected implements _Unselected {
  const _$_Unselected();

  @override
  String toString() {
    return 'MoviesState.unselected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Unselected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unselected,
    required TResult Function(Movie movie) selected,
  }) {
    return unselected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unselected,
    TResult? Function(Movie movie)? selected,
  }) {
    return unselected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unselected,
    TResult Function(Movie movie)? selected,
    required TResult orElse(),
  }) {
    if (unselected != null) {
      return unselected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unselected value) unselected,
    required TResult Function(_Selected value) selected,
  }) {
    return unselected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unselected value)? unselected,
    TResult? Function(_Selected value)? selected,
  }) {
    return unselected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unselected value)? unselected,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (unselected != null) {
      return unselected(this);
    }
    return orElse();
  }
}

abstract class _Unselected implements MoviesState {
  const factory _Unselected() = _$_Unselected;
}

/// @nodoc
abstract class _$$_SelectedCopyWith<$Res> {
  factory _$$_SelectedCopyWith(
          _$_Selected value, $Res Function(_$_Selected) then) =
      __$$_SelectedCopyWithImpl<$Res>;
  @useResult
  $Res call({Movie movie});

  $MovieCopyWith<$Res> get movie;
}

/// @nodoc
class __$$_SelectedCopyWithImpl<$Res>
    extends _$MoviesStateCopyWithImpl<$Res, _$_Selected>
    implements _$$_SelectedCopyWith<$Res> {
  __$$_SelectedCopyWithImpl(
      _$_Selected _value, $Res Function(_$_Selected) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? movie = null,
  }) {
    return _then(_$_Selected(
      null == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Movie,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MovieCopyWith<$Res> get movie {
    return $MovieCopyWith<$Res>(_value.movie, (value) {
      return _then(_value.copyWith(movie: value));
    });
  }
}

/// @nodoc

class _$_Selected implements _Selected {
  const _$_Selected(this.movie);

  @override
  final Movie movie;

  @override
  String toString() {
    return 'MoviesState.selected(movie: $movie)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Selected &&
            (identical(other.movie, movie) || other.movie == movie));
  }

  @override
  int get hashCode => Object.hash(runtimeType, movie);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      __$$_SelectedCopyWithImpl<_$_Selected>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unselected,
    required TResult Function(Movie movie) selected,
  }) {
    return selected(movie);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unselected,
    TResult? Function(Movie movie)? selected,
  }) {
    return selected?.call(movie);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unselected,
    TResult Function(Movie movie)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(movie);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unselected value) unselected,
    required TResult Function(_Selected value) selected,
  }) {
    return selected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unselected value)? unselected,
    TResult? Function(_Selected value)? selected,
  }) {
    return selected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unselected value)? unselected,
    TResult Function(_Selected value)? selected,
    required TResult orElse(),
  }) {
    if (selected != null) {
      return selected(this);
    }
    return orElse();
  }
}

abstract class _Selected implements MoviesState {
  const factory _Selected(final Movie movie) = _$_Selected;

  Movie get movie;
  @JsonKey(ignore: true)
  _$$_SelectedCopyWith<_$_Selected> get copyWith =>
      throw _privateConstructorUsedError;
}
