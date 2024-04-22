import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: "/fFWdqlnBVNMLDneYUeQLFuPBq4Z.jpg",
  genreIds: [16, 10759],
  id: 888,
  originCountry: ["US"],
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

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/fFWdqlnBVNMLDneYUeQLFuPBq4Z.jpg",
  genres: [
    Genre(id: 16, name: 'Animation'),
    Genre(id: 10759, name: 'Action & Adventure')
  ],
  id: 888,
  originalTitle: 'Spider-Man',
  overview:
      'Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.',
  posterPath: '/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg',
  releaseDate: '1994-11-19',
  voteAverage: 8.267,
  voteCount: 970,
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 888,
  originalName: 'Spider-Man',
  posterPath: '/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg',
  overview:
      'Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.',
);

final testTvSeriesTable = TvSeriesTable(
  id: 888,
  title: 'Spider-Man',
  posterPath: '/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg',
  overview:
      'Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.',
);

final testTvSeriesMap = {
  "id": 888,
  "title": 'Spider-Man',
  "posterPath": '/m78QRL6puLJ9pXSQ8XMd3dVKOOW.jpg',
  "overview":
      'Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.',
};
