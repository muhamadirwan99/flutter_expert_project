import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingTvSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  RequestState _nowPlayingTvSeriesState = RequestState.Empty;
  RequestState get nowPlayingTvSeriesState => _nowPlayingTvSeriesState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  // var _topRatedMovies = <Movie>[];
  // List<Movie> get topRatedMovies => _topRatedMovies;

  // RequestState _topRatedMoviesState = RequestState.Empty;
  // RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    // required this.getTopRatedMovies,
  });

  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  // final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingTvSeries() async {
    _nowPlayingTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingTvSeriesState = RequestState.Loaded;
        _nowPlayingTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  // Future<void> fetchTopRatedMovies() async {
  //   _topRatedMoviesState = RequestState.Loading;
  //   notifyListeners();

  //   final result = await getTopRatedMovies.execute();
  //   result.fold(
  //     (failure) {
  //       _topRatedMoviesState = RequestState.Error;
  //       _message = failure.message;
  //       notifyListeners();
  //     },
  //     (moviesData) {
  //       _topRatedMoviesState = RequestState.Loaded;
  //       _topRatedMovies = moviesData;
  //       notifyListeners();
  //     },
  //   );
  // }
}
