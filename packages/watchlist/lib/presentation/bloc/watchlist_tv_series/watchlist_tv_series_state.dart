part of 'watchlist_tv_series_bloc.dart';

sealed class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object?> get props => [];
}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final Failure error;

  const WatchlistTvSeriesError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  const WatchlistTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
