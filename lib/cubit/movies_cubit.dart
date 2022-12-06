import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/models/movie.dart';

part 'movies_state.dart';
part 'movies_cubit.freezed.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(const MoviesState.unselected());

  void getSelectedMovie(Movie movie) {
    emit(MoviesState.selected(movie));
  }

  void unselectMovie() {
    emit(const MoviesState.unselected());
  }
}
