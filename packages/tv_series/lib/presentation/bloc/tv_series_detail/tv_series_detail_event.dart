part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;
  const FetchTvSeriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTvSeriesRecommendation extends TvSeriesDetailEvent {
  final int id;

  const FetchTvSeriesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvSeriesWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class DeleteTvSeriesWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  const DeleteTvSeriesWatchlist(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}
