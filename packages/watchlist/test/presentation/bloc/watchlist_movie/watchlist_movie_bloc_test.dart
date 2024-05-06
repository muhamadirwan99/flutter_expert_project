import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';
import '../../../../../core/test/dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistBloc;
  late MockGetWatchlistMovies mockWatchlist;

  setUp(() {
    mockWatchlist = MockGetWatchlistMovies();
    watchlistBloc = WatchlistMovieBloc(mockWatchlist);
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockWatchlist.execute()).thenAnswer(
        (_) async => Right([testWatchlistMovie]),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    verify: (bloc) {
      verify(mockWatchlist.execute());
    },
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData([testWatchlistMovie]),
    ],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockWatchlist.execute()).thenAnswer(
        (_) async => const Left(DatabaseFailure("Can't get data")),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    verify: (bloc) {
      verify(mockWatchlist.execute());
    },
    expect: () => [
      WatchlistMovieLoading(),
      const WatchlistMovieError(DatabaseFailure("Can't get data")),
    ],
  );
}
