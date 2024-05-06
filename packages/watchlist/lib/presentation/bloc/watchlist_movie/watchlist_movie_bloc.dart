import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _watchlist;

  WatchlistMovieBloc(this._watchlist) : super(WatchlistMovieEmpty()) {
    on<WatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _watchlist.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure)),
        (data) => emit(WatchlistMovieHasData(data)),
      );
    });
  }
}
