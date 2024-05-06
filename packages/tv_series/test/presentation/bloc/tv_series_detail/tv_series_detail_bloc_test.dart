import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:core/core.dart';
import 'package:mockito/mockito.dart';
import '../../../../../core/test/dummy_data/dummy_objects.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc blocDetail;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatusTvSeries mockGetWatchListStatusTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchListStatusTvSeries = MockGetWatchListStatusTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    blocDetail = TvSeriesDetailBloc(
      mockGetTvSeriesDetail as GetTvSeriesDetail,
      mockGetTvSeriesRecommendations as GetTvSeriesRecommendations,
      mockGetWatchListStatusTvSeries as GetWatchListStatusTvSeries,
      mockSaveWatchlistTvSeries as SaveWatchlistTvSeries,
      mockRemoveWatchlistTvSeries as RemoveWatchlistTvSeries,
    );
  });

  const tId = 1;

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
  final tTvSerieses = <TvSeries>[tTvSeries];

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change TvSeries when data is gotten successfully with isWatchlist',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
          (_) async => const Right(testTvSeriesDetail),
        );
        when(mockGetWatchListStatusTvSeries.execute(tId)).thenAnswer(
          (_) async => true,
        );
        return blocDetail;
      },
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
      act: (bloc) => blocDetail.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(),
        blocDetail.state.copyWith(
          isLoading: false,
          data: testTvSeriesDetail,
          isWatchlist: true,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change TvSeries when data is gotten successfully with isNotWatchlist',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
          (_) async => const Right(testTvSeriesDetail),
        );
        when(mockGetWatchListStatusTvSeries.execute(tId)).thenAnswer(
          (_) async => false,
        );
        return blocDetail;
      },
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
      act: (bloc) => blocDetail.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(),
        blocDetail.state.copyWith(
          isLoading: false,
          data: testTvSeriesDetail,
          isWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change TvSeries when data is gotten error',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        when(mockGetWatchListStatusTvSeries.execute(tId)).thenAnswer(
          (_) async => false,
        );
        return blocDetail;
      },
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
        verify(mockGetWatchListStatusTvSeries.execute(tId));
      },
      act: (bloc) => blocDetail.add(const FetchTvSeriesDetail(tId)),
      expect: () => [
        const TvSeriesDetailState(),
        blocDetail.state.copyWith(
          isLoading: false,
          isWatchlist: false,
          error: const ServerFailure('Server Failure'),
        ),
      ],
    );
  });

  group('Get TvSeries Recommendations', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change recommendation when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
          (_) async => Right(tTvSerieses),
        );
        return blocDetail;
      },
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
      act: (bloc) => blocDetail.add(const FetchTvSeriesRecommendation(tId)),
      expect: () => [
        const TvSeriesDetailState(),
        blocDetail.state.copyWith(
          isLoadingRecommendation: false,
          dataRecomendation: tTvSerieses,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change recommendation when data is gotten error',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return blocDetail;
      },
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
      act: (bloc) => blocDetail.add(const FetchTvSeriesRecommendation(tId)),
      expect: () => [
        const TvSeriesDetailState(),
        blocDetail.state.copyWith(
          isLoadingRecommendation: false,
          errorRecommendation: const ServerFailure('Server Failure'),
        ),
      ],
    );

    group('Watchlist', () {
      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        'should return isWatchlist true when success',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer(
            (_) async => const Right('Added to Watchlist'),
          );
          when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
              .thenAnswer(
            (_) async => true,
          );
          return blocDetail;
        },
        verify: (bloc) {
          verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
          verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
        },
        act: (bloc) =>
            blocDetail.add(const AddTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          blocDetail.state.copyWith(
            isWatchlist: true,
          ),
        ],
      );

      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        'should return isWatchlist false when error',
        build: () {
          when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')),
          );
          when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
              .thenAnswer(
            (_) async => false,
          );
          return blocDetail;
        },
        verify: (bloc) {
          verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
          verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
        },
        act: (bloc) =>
            blocDetail.add(const AddTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          blocDetail.state.copyWith(
            isWatchlist: false,
          ),
        ],
      );

      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        'should return isWatchlist false when success remove',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer(
            (_) async => const Right('Removed from Watchlist'),
          );
          when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
              .thenAnswer(
            (_) async => false,
          );
          return blocDetail;
        },
        verify: (bloc) {
          verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
          verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
        },
        act: (bloc) =>
            blocDetail.add(const DeleteTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          blocDetail.state.copyWith(
            isWatchlist: false,
          ),
        ],
      );

      blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
        'should return isWatchlist true when failed remove',
        build: () {
          when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
              .thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')),
          );
          when(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id))
              .thenAnswer(
            (_) async => true,
          );
          return blocDetail;
        },
        verify: (bloc) {
          verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
          verify(mockGetWatchListStatusTvSeries.execute(testTvSeriesDetail.id));
        },
        act: (bloc) =>
            blocDetail.add(const DeleteTvSeriesWatchlist(testTvSeriesDetail)),
        expect: () => [
          blocDetail.state.copyWith(
            isWatchlist: true,
          ),
        ],
      );
    });
  });
}
