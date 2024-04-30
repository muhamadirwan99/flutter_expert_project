import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
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

  group('now playing TvSeries', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingTvSeriesState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchNowPlayingTvSeries();
      // assert
      verify(mockGetNowPlayingTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingTvSeriesState, RequestState.Loading);
    });

    test('should change TvSeries when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingTvSeriesState, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular TvSeries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change TvSeries data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated TvSeries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change TvSeries data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
