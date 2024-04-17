import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  // final GetMovieRecommendations getMovieRecommendations;
  // final GetWatchListStatus getWatchListStatus;
  // final SaveWatchlist saveWatchlist;
  // final RemoveWatchlist removeWatchlist;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    // required this.getMovieRecommendations,
    // required this.getWatchListStatus,
    // required this.saveWatchlist,
    // required this.removeWatchlist,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  // List<Movie> _movieRecommendations = [];
  // List<Movie> get movieRecommendations => _movieRecommendations;

  // RequestState _recommendationState = RequestState.Empty;
  // RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  // bool _isAddedtoWatchlist = false;
  // bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    // final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        // _recommendationState = RequestState.Loading;
        _tvSeries = movie;
        notifyListeners();
        // recommendationResult.fold(
        //   (failure) {
        //     _recommendationState = RequestState.Error;
        //     _message = failure.message;
        //   },
        //   (movies) {
        //     _recommendationState = RequestState.Loaded;
        //     _movieRecommendations = movies;
        //   },
        // );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  // String _watchlistMessage = '';
  // String get watchlistMessage => _watchlistMessage;

  // Future<void> addWatchlist(MovieDetail movie) async {
  //   final result = await saveWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> removeFromWatchlist(MovieDetail movie) async {
  //   final result = await removeWatchlist.execute(movie);

  //   await result.fold(
  //     (failure) async {
  //       _watchlistMessage = failure.message;
  //     },
  //     (successMessage) async {
  //       _watchlistMessage = successMessage;
  //     },
  //   );

  //   await loadWatchlistStatus(movie.id);
  // }

  // Future<void> loadWatchlistStatus(int id) async {
  //   final result = await getWatchListStatus.execute(id);
  //   _isAddedtoWatchlist = result;
  //   notifyListeners();
  // }
}
