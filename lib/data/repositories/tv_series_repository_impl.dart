import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  // final TvSeriesLoca localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // @override
  // Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
  //   try {
  //     final result = await remoteDataSource.getMovieDetail(id);
  //     return Right(result.toEntity());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  // @override
  // Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
  //   try {
  //     final result = await remoteDataSource.getMovieRecommendations(id);
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  // @override
  // Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
  //   try {
  //     final result = await remoteDataSource.searchMovies(query);
  //     return Right(result.map((model) => model.toEntity()).toList());
  //   } on ServerException {
  //     return Left(ServerFailure(''));
  //   } on SocketException {
  //     return Left(ConnectionFailure('Failed to connect to the network'));
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
  //   try {
  //     final result =
  //         await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
  //     return Right(result);
  //   } on DatabaseException catch (e) {
  //     return Left(DatabaseFailure(e.message));
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
  //   try {
  //     final result =
  //         await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
  //     return Right(result);
  //   } on DatabaseException catch (e) {
  //     return Left(DatabaseFailure(e.message));
  //   }
  // }

  // @override
  // Future<bool> isAddedToWatchlist(int id) async {
  //   final result = await localDataSource.getMovieById(id);
  //   return result != null;
  // }

  // @override
  // Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
  //   final result = await localDataSource.getWatchlistMovies();
  //   return Right(result.map((data) => data.toEntity()).toList());
  // }
}