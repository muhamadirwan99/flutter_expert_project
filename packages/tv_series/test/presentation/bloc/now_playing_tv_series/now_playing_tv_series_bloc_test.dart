import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';

import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeries;
  late MockGetNowPlayingTvSeries mockList;

  setUp(() {
    mockList = MockGetNowPlayingTvSeries();
    nowPlayingTvSeries =
        NowPlayingTvSeriesBloc(mockList as GetNowPlayingTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/fFWdqlnBVNMLDneYUeQLFuPBq4Z.jpg",
    genreIds: const [16, 10759],
    id: 888,
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Spider-Man",
    overview:
        "Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.",
    popularity: 197.224,
    posterPath: "/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg",
    firstAirDate: "1994-11-19",
    name: "Spider-Man",
    voteAverage: 8.267,
    voteCount: 970,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initialState now playing TvSeries should be empty', () {
    expect(nowPlayingTvSeries.state, equals(NowPlayingTvSeriesEmpty()));
  });

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should change now playing TvSeries data when data is gotten successfully',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => Right(tTvSeriesList),
      );
      return nowPlayingTvSeries;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return nowPlayingTvSeries;
    },
    act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      NowPlayingTvSeriesLoading(),
      const NowPlayingTvSeriesError(ServerFailure('Server Failure')),
    ],
  );
}
