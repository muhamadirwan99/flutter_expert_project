import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';
import '../../../../../core/test/dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistBloc;
  late MockGetWatchlistTvSeries mockWatchlist;

  setUp(() {
    mockWatchlist = MockGetWatchlistTvSeries();
    watchlistBloc = WatchlistTvSeriesBloc(mockWatchlist);
  });

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should change TvSeries data when data is gotten successfully',
    build: () {
      when(mockWatchlist.execute()).thenAnswer(
        (_) async => Right([testWatchlistTvSeries]),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    verify: (bloc) {
      verify(mockWatchlist.execute());
    },
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData([testWatchlistTvSeries]),
    ],
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockWatchlist.execute()).thenAnswer(
        (_) async => const Left(DatabaseFailure("Can't get data")),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    verify: (bloc) {
      verify(mockWatchlist.execute());
    },
    expect: () => [
      WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError(DatabaseFailure("Can't get data")),
    ],
  );
}
