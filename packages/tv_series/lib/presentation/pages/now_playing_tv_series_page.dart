import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  const NowPlayingTvSeriesPage({super.key});

  @override
  _NowPlayingTvSeriesPageState createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NowPlayingTvSeriesBloc>().add(FetchNowPlayingTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
            builder: (context, state) {
          if (state is NowPlayingTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.result.length,
            );
          } else if (state is NowPlayingTvSeriesError) {
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
