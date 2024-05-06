import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
            builder: (context, state) {
          if (state is PopularTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.result.length,
            );
          } else if (state is PopularTvSeriesError) {
            return Expanded(
              child: Center(
                child: Text(state.error.message),
              ),
            );
          } else {
            return const Text('Failed');
          }
        }),
      ),
    );
  }
}
