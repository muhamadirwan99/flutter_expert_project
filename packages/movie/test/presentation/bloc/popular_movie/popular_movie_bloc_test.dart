import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovie;
  late MockGetPopularMovies mockList;

  setUp(() {
    mockList = MockGetPopularMovies();
    popularMovie = PopularMovieBloc(mockList as GetPopularMovies);
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

  test('initialState popular movies should be empty', () {
    expect(popularMovie.state, equals(PopularMovieEmpty()));
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should change popular movies data when data is gotten successfully',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return popularMovie;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(tMovieList),
    ],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return popularMovie;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      PopularMovieLoading(),
      const PopularMovieError(ServerFailure('Server Failure')),
    ],
  );
}
