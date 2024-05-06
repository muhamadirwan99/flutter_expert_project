import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _movieDetails;
  final GetMovieRecommendations _movieRecommendations;
  final GetWatchListStatus _loadWatchlistStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc(
    this._movieDetails,
    this._movieRecommendations,
    this._loadWatchlistStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(const MovieDetailState()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataResult = await _movieDetails.execute(event.id);
      final status = await loadWatchlistStatus(event.id);
      dataResult.fold(
        (fail) => emit(state.copyWith(
          isLoading: false,
          error: fail,
        )),
        (movie) => emit(state.copyWith(
          isLoading: false,
          data: movie,
          isWatchlist: status,
        )),
      );
    });

    on<FetchMovieRecommendation>((event, emit) async {
      emit(state.copyWith(isLoadingRecommendation: true));
      final dataResult = await _movieRecommendations.execute(event.id);
      dataResult.fold(
        (fail) => emit(state.copyWith(
          isLoadingRecommendation: false,
          errorRecommendation: fail,
        )),
        (movie) => emit(state.copyWith(
          isLoadingRecommendation: false,
          dataRecomendation: movie,
        )),
      );
    });

    on<AddMovieWatchlist>((event, emit) async {
      final saveWatchList = await _saveWatchlist.execute(event.movie);
      final status = await loadWatchlistStatus(event.movie.id);
      saveWatchList.fold(
        (fail) => emit(state.copyWith(
          isWatchlist: false,
          message: fail.message,
        )),
        (message) => emit(state.copyWith(
          isWatchlist: status,
          message: message,
        )),
      );
    });

    on<DeleteMovieWatchlist>((event, emit) async {
      final removeWatchlist = await _removeWatchlist.execute(event.movie);
      final status = await loadWatchlistStatus(event.movie.id);
      removeWatchlist.fold(
        (fail) => emit(state.copyWith(
          isWatchlist: true,
          message: fail.message,
        )),
        (message) => emit(state.copyWith(
          isWatchlist: status,
          message: message,
        )),
      );
    });
  }

  Future<bool> loadWatchlistStatus(int id) async {
    final result = await _loadWatchlistStatus.execute(id);
    return result;
  }
}
