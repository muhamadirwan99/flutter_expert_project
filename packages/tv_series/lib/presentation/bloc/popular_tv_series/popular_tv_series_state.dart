part of 'popular_tv_series_bloc.dart';

sealed class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object?> get props => [];
}

final class PopularTvSeriesEmpty extends PopularTvSeriesState {}

final class PopularTvSeriesLoading extends PopularTvSeriesState {}

final class PopularTvSeriesError extends PopularTvSeriesState {
  final Failure error;

  const PopularTvSeriesError(this.error);
  @override
  List<Object> get props => [error];
}

final class PopularTvSeriesHasData extends PopularTvSeriesState {
  final List<TvSeries> result;

  const PopularTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
