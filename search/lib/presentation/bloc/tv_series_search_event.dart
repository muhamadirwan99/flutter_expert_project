part of 'tv_series_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangedTvSeries extends TvSeriesSearchEvent {
  final String query;

  const OnQueryChangedTvSeries(this.query);

  @override
  List<Object> get props => [query];
}

EventTransformer<T> debounceTvSeries<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
