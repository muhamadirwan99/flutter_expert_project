import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovie;
  late MockGetTopRatedMovies mockList;

  setUp(() {
    mockList = MockGetTopRatedMovies();
    topRatedMovie = TopRatedMovieBloc(mockList as GetTopRatedMovies);
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

  test('initialState top rated movies should be empty', () {
    expect(topRatedMovie.state, equals(TopRatedMovieEmpty()));
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should change top rated movies data when data is gotten successfully',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return topRatedMovie;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(tMovieList),
    ],
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockList.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return topRatedMovie;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    verify: (bloc) {
      verify(mockList.execute());
    },
    expect: () => [
      TopRatedMovieLoading(),
      const TopRatedMovieError(ServerFailure('Server Failure')),
    ],
  );
}
