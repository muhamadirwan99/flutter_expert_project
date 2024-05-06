import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail _tvSeriesDetails;
  final GetTvSeriesRecommendations _tvSeriesRecommendations;
  final GetWatchListStatusTvSeries _loadWatchlistStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  TvSeriesDetailBloc(
    this._tvSeriesDetails,
    this._tvSeriesRecommendations,
    this._loadWatchlistStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  ) : super(const TvSeriesDetailState()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final dataResult = await _tvSeriesDetails.execute(event.id);
      final status = await loadWatchlistStatusTvSeries(event.id);
      dataResult.fold(
        (fail) => emit(state.copyWith(
          isLoading: false,
          error: fail,
        )),
        (tvSeries) => emit(state.copyWith(
          isLoading: false,
          data: tvSeries,
          isWatchlist: status,
        )),
      );
    });

    on<FetchTvSeriesRecommendation>((event, emit) async {
      emit(state.copyWith(isLoadingRecommendation: true));
      final dataResult = await _tvSeriesRecommendations.execute(event.id);
      dataResult.fold(
        (fail) => emit(state.copyWith(
          isLoadingRecommendation: false,
          errorRecommendation: fail,
        )),
        (tvSeries) => emit(state.copyWith(
          isLoadingRecommendation: false,
          dataRecomendation: tvSeries,
        )),
      );
    });

    on<AddTvSeriesWatchlist>((event, emit) async {
      final saveWatchList =
          await _saveWatchlistTvSeries.execute(event.tvSeriesDetail);
      final status = await loadWatchlistStatusTvSeries(event.tvSeriesDetail.id);
      saveWatchList.fold(
        (fail) => emit(state.copyWith(
          isWatchlist: false,
        )),
        (message) => emit(state.copyWith(
          isWatchlist: status,
        )),
      );
    });

    on<DeleteTvSeriesWatchlist>((event, emit) async {
      final removeWatchlist =
          await _removeWatchlistTvSeries.execute(event.tvSeriesDetail);
      final status = await loadWatchlistStatusTvSeries(event.tvSeriesDetail.id);
      removeWatchlist.fold(
        (fail) => emit(state.copyWith(
          isWatchlist: true,
        )),
        (message) => emit(state.copyWith(
          isWatchlist: status,
        )),
      );
    });
  }

  Future<bool> loadWatchlistStatusTvSeries(int id) async {
    final result = await _loadWatchlistStatusTvSeries.execute(id);
    return result;
  }
}
