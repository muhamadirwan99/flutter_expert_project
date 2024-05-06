import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _watchlist;

  WatchlistTvSeriesBloc(this._watchlist) : super(WatchlistTvSeriesEmpty()) {
    on<WatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await _watchlist.execute();
      result.fold(
        (failure) => emit(WatchlistTvSeriesError(failure)),
        (data) => emit(WatchlistTvSeriesHasData(data)),
      );
    });
  }
}
