import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/provider/tv_series_detail_notifier.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import '../../../../core/test/presentation/pages/tv_series/tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when TvSeries not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TvSeries is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
