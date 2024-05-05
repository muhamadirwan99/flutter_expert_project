part of 'now_playing_movie_bloc.dart';

sealed class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object?> get props => [];
}

final class NowPlayingMovieEmpty extends NowPlayingMovieState {}

final class NowPlayingMovieLoading extends NowPlayingMovieState {}

final class NowPlayingMovieError extends NowPlayingMovieState {
  final Failure error;

  const NowPlayingMovieError(this.error);
  @override
  List<Object> get props => [error];
}

final class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> result;

  const NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
