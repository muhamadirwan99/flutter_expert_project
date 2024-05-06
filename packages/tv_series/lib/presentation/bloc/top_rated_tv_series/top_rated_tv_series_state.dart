part of 'top_rated_tv_series_bloc.dart';

sealed class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object?> get props => [];
}

final class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {}

final class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

final class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final Failure error;

  const TopRatedTvSeriesError(this.error);
  @override
  List<Object> get props => [error];
}

final class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
  final List<TvSeries> result;

  const TopRatedTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
