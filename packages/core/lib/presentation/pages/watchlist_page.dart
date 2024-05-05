import 'package:core/core.dart';
import 'package:core/presentation/provider/tv_series/watchlist_tv_series_notifier.dart';
import 'package:core/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({super.key});

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    text: 'Movie',
                  ),
                  Tab(
                    text: 'TV Series',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Consumer<WatchlistMovieNotifier>(
                        builder: (context, data, child) {
                          if (data.watchlistState == RequestState.Loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.watchlistState ==
                              RequestState.Loaded) {
                            if (data.watchlistMovies.isEmpty) {
                              return const Center(
                                key: Key('empty_message'),
                                child: Text(
                                    'No data available, add some movies to your watchlist!,'),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = data.watchlistMovies[index];
                                return MovieCard(movie);
                              },
                              itemCount: data.watchlistMovies.length,
                            );
                          } else {
                            return Center(
                              key: const Key('error_message'),
                              child: Text(data.message),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Consumer<WatchlistTvSeriesNotifier>(
                        builder: (context, data, child) {
                          if (data.watchlistState == RequestState.Loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.watchlistState ==
                              RequestState.Loaded) {
                            if (data.watchlistTvSeries.isEmpty) {
                              return const Center(
                                key: Key('empty_message'),
                                child: Text(
                                    'No data available, add some TV Series to your watchlist!,'),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = data.watchlistTvSeries[index];
                                return TvSeriesCard(movie);
                              },
                              itemCount: data.watchlistTvSeries.length,
                            );
                          } else {
                            return Center(
                              key: const Key('error_message'),
                              child: Text(data.message),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
