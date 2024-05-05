import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries _searchTvSeries;

  TvSeriesSearchBloc(this._searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<OnQueryChangedTvSeries>((event, emit) async {
      final query = event.query;

      emit(TvSeriesSearchLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold((failure) {
        emit(TvSeriesSearchError(failure.message));
      }, (data) {
        emit(TvSeriesSearchHasData(data));
      });
    }, transformer: debounceTvSeries(const Duration(milliseconds: 500)));
  }
}
