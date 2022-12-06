part of 'movies_cubit.dart';

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.unselected() = _Unselected;
  const factory MoviesState.selected(Movie movie) = _Selected;
}
