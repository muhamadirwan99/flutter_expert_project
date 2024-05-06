part of 'now_playing_tv_series_bloc.dart';

sealed class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object?> get props => [];
}

final class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {}

final class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {}

final class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final Failure error;

  const NowPlayingTvSeriesError(this.error);
  @override
  List<Object> get props => [error];
}

final class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  final List<TvSeries> result;

  const NowPlayingTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
