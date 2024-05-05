import 'package:core/core.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:search/search.dart';

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
                            onChanged: (query) {
                              context
                                  .read<TvSeriesSearchBloc>()
                                  .add(OnQueryChangedTvSeries(query));
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
                          BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                            builder: (context, state) {
                              if (state is TvSeriesSearchLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is TvSeriesSearchHasData) {
                                final result = state.result;
                                return Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final tvSeries = result[index];
                                      return TvSeriesCard(tvSeries);
                                    },
                                    itemCount: result.length,
                                  ),
                                );
                              } else if (state is TvSeriesSearchError) {
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
