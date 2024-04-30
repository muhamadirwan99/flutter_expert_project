import 'package:core/data/models/tv_series/tv_series_model.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'releaseDate',
    name: 'title',
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
