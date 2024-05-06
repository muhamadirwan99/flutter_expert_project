import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';

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
    Future.microtask(
        () => context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie()));
    Future.microtask(() =>
        context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
        () => context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie()));
    Future.microtask(() =>
        context.read<WatchlistTvSeriesBloc>().add(FetchWatchlistTvSeries()));
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
                      child:
                          BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                        builder: (context, state) {
                          if (state is WatchlistMovieLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is WatchlistMovieHasData) {
                            if (state.result.isEmpty) {
                              return const Center(
                                key: Key('empty_message'),
                                child: Text(
                                    'No data available, add some movies to your watchlist!,'),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = state.result[index];
                                return MovieCard(movie);
                              },
                              itemCount: state.result.length,
                            );
                          } else if (state is WatchlistMovieError) {
                            return Expanded(
                              child: Center(
                                child: Text(state.error.message),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: BlocBuilder<WatchlistTvSeriesBloc,
                          WatchlistTvSeriesState>(
                        builder: (context, state) {
                          if (state is WatchlistTvSeriesLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is WatchlistTvSeriesHasData) {
                            if (state.result.isEmpty) {
                              return const Center(
                                key: Key('empty_message'),
                                child: Text(
                                    'No data available, add some TvSeries to your watchlist!,'),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final tvSeries = state.result[index];
                                return TvSeriesCard(tvSeries);
                              },
                              itemCount: state.result.length,
                            );
                          } else if (state is WatchlistTvSeriesError) {
                            return Expanded(
                              child: Center(
                                child: Text(state.error.message),
                              ),
                            );
                          } else {
                            return Container();
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
