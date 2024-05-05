import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _popularMovies;

  PopularMovieBloc(this._popularMovies) : super(PopularMovieEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _popularMovies.execute();

      result.fold(
        (failure) => emit(PopularMovieError(failure)),
        (data) => emit(PopularMovieHasData(data)),
      );
    });
  }
}
