part of 'popular_movie_bloc.dart';

sealed class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends PopularMovieEvent {}
