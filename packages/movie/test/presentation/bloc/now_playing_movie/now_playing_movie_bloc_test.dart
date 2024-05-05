import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieBloc nowPlayingMovie;
  late MockGetNowPlayingMovies mockList;

  setUp(() {
    mockList = MockGetNowPlayingMovies();
    nowPlayingMovie = NowPlayingMovieBloc(mockList as GetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initialState now playing movies should be empty', () {
    expect(nowPlayingMovie.state, equals(NowPlayingMovieEmpty()));
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'should change now playing movies data when data is gotten successfully',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return nowPlayingMovie;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      NowPlayingMovieLoading(),
      NowPlayingMovieHasData(tMovieList),
    ],
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return nowPlayingMovie;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      NowPlayingMovieLoading(),
      const NowPlayingMovieError(ServerFailure('Server Failure')),
    ],
  );
}
