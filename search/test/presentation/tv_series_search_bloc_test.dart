import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/search.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc tvSeriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchBloc = TvSeriesSearchBloc(mockSearchTvSeries);
  });

  test('initial state should be TvSeriesSearchEmpty', () {
    expect(tvSeriesSearchBloc.state, TvSeriesSearchEmpty());
  });

  final tTvSeriesModel = TvSeries(
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
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  const tQuery = 'spiderman';

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));

      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedTvSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedTvSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
