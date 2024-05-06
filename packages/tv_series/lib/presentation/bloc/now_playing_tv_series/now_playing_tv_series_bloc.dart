import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _nowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this._nowPlayingTvSeries)
      : super(NowPlayingTvSeriesEmpty()) {
    on<FetchNowPlayingTvSeries>((event, emit) async {
      emit(NowPlayingTvSeriesLoading());
      final result = await _nowPlayingTvSeries.execute();

      result.fold(
        (failure) => emit(NowPlayingTvSeriesError(failure)),
        (data) => emit(NowPlayingTvSeriesHasData(data)),
      );
    });
  }
}
