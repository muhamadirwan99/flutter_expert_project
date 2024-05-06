import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:tv_series/tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _popularTvSeries;

  PopularTvSeriesBloc(this._popularTvSeries) : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await _popularTvSeries.execute();

      result.fold(
        (failure) => emit(PopularTvSeriesError(failure)),
        (data) => emit(PopularTvSeriesHasData(data)),
      );
    });
  }
}
