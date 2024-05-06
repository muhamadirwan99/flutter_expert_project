part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final bool isLoading;
  final bool isLoadingRecommendation;
  final bool isWatchlist;
  final String? message;
  final Failure? error;
  final Failure? errorRecommendation;
  final TvSeriesDetail? data;
  final List<TvSeries>? dataRecomendation;

  const TvSeriesDetailState({
    this.isLoading = true,
    this.isLoadingRecommendation = true,
    this.isWatchlist = false,
    this.message,
    this.error,
    this.errorRecommendation,
    this.data,
    this.dataRecomendation,
  });

  TvSeriesDetailState copyWith({
    bool? isLoading,
    bool? isLoadingRecommendation,
    bool? isWatchlist,
    String? message,
    Failure? error,
    final Failure? errorRecommendation,
    final TvSeriesDetail? data,
    final List<TvSeries>? dataRecomendation,
  }) {
    return TvSeriesDetailState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingRecommendation:
          isLoadingRecommendation ?? this.isLoadingRecommendation,
      isWatchlist: isWatchlist ?? this.isWatchlist,
      message: message ?? this.message,
      error: error ?? this.error,
      errorRecommendation: errorRecommendation ?? this.errorRecommendation,
      data: data ?? this.data,
      dataRecomendation: dataRecomendation ?? this.dataRecomendation,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingRecommendation,
        isWatchlist,
        message,
        error,
        errorRecommendation,
        data,
        dataRecomendation,
      ];
}
