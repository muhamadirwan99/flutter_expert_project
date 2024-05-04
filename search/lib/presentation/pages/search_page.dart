import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import '../provider/movie_search_notifier.dart';
import 'package:core/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onChanged: (query) {
                              context
                                  .read<SearchBloc>()
                                  .add(OnQueryChanged(query));
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search title',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.search,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Search Result',
                            style: kHeading6,
                          ),
                          BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is SearchHasData) {
                                final result = state.result;
                                return Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final movie = result[index];
                                      return MovieCard(movie);
                                    },
                                    itemCount: result.length,
                                  ),
                                );
                              } else if (state is SearchError) {
                                return Expanded(
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: Container(
                                    child: const Text(
                                      "Search in the search bar above",
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            onSubmitted: (query) {
                              Provider.of<TvSeriesSearchNotifier>(context,
                                      listen: false)
                                  .fetchTvSeriesSearch(query);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search title',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.search,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Search Result',
                            style: kHeading6,
                          ),
                          Consumer<TvSeriesSearchNotifier>(
                            builder: (context, data, child) {
                              if (data.state == RequestState.Loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (data.state == RequestState.Loaded) {
                                final result = data.searchResult;
                                return Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final tvSeries = data.searchResult[index];
                                      return TvSeriesCard(tvSeries);
                                    },
                                    itemCount: result.length,
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: Container(
                                    child: const Text(
                                      "Search in the search bar above",
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
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
}