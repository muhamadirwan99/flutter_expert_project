import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _topRatedTvSeries;

  TopRatedTvSeriesBloc(this._topRatedTvSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<FetchTopRatedTvSeries>((event, emit) async {
      emit(TopRatedTvSeriesLoading());
      final result = await _topRatedTvSeries.execute();

      result.fold(
        (failure) => emit(TopRatedTvSeriesError(failure)),
        (data) => emit(TopRatedTvSeriesHasData(data)),
      );
    });
  }
}
