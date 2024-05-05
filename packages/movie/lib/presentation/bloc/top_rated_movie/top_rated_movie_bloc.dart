import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedMovieBloc(this._topRatedMovies) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _topRatedMovies.execute();

      result.fold(
        (failure) => emit(TopRatedMovieError(failure)),
        (data) => emit(TopRatedMovieHasData(data)),
      );
    });
  }
}
