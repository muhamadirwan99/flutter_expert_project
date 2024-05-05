import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/movie.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMovieBloc(this._nowPlayingMovies) : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _nowPlayingMovies.execute();

      result.fold(
        (failure) => emit(NowPlayingMovieError(failure)),
        (data) => emit(NowPlayingMovieHasData(data)),
      );
    });
  }
}
