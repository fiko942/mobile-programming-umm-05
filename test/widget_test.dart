// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloworldfiko/main.dart';

void main() {
  // No network overrides needed now; About page uses an in-test placeholder image.

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and measure initial build time
    final buildWatch = Stopwatch()..start();
    await tester.pumpWidget(const MyApp());
    buildWatch.stop();
    // Print initial build duration
    // Note: Times are from test environment and approximate.
    // They help compare changes over time rather than serve as absolute metrics.
    // ignore: avoid_print
    print('Initial widget build: ${buildWatch.elapsedMilliseconds} ms');

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

  // Tap the '+' icon and measure the interaction time (tap + pump)
  final incrementButton = find.widgetWithIcon(CupertinoButton, CupertinoIcons.add);
  final tapWatch = Stopwatch()..start();
  await tester.tap(incrementButton);
  await tester.pump();
  tapWatch.stop();
  // ignore: avoid_print
  print('Single increment interaction: ${tapWatch.elapsedMilliseconds} ms');

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Navigation performance between tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Initial tab should be Counter (index 0)
    expect(find.text('Counter'), findsWidgets);

    // Switch to About tab and back multiple times, measuring durations
    final tabBar = find.byType(CupertinoTabBar);
    final aboutTab = find.descendant(of: tabBar, matching: find.byIcon(CupertinoIcons.info));
    final counterTab = find.descendant(of: tabBar, matching: find.byIcon(CupertinoIcons.add));

    final totalWatch = Stopwatch()..start();
    final perSwitchDurations = <int>[];
    for (var i = 0; i < 5; i++) {
      final loopWatch = Stopwatch()..start();
      await tester.tap(aboutTab);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('About'), findsWidgets);

      await tester.tap(counterTab);
      await tester.pumpAndSettle(const Duration(milliseconds: 200));
      expect(find.text('Counter'), findsWidgets);
      loopWatch.stop();
      perSwitchDurations.add(loopWatch.elapsedMilliseconds);
    }
    totalWatch.stop();

    // Soft assertion: navigation loops complete within a reasonable time in tests
    expect(totalWatch.elapsed.inSeconds < 2, isTrue,
        reason: 'Tab switching took too long in test environment');

    // Report timings
    final avg = perSwitchDurations.isEmpty
        ? 0
        : perSwitchDurations.reduce((a, b) => a + b) ~/ perSwitchDurations.length;
    // ignore: avoid_print
  print('Navigation: total=${totalWatch.elapsedMilliseconds} ms, '
    'avg per loop=$avg ms, samples=$perSwitchDurations');
  });

  testWidgets('Counter rapid increment performance', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final incrementButton = find.widgetWithIcon(CupertinoButton, CupertinoIcons.add);

    final watch = Stopwatch()..start();
    for (var i = 0; i < 20; i++) {
      await tester.tap(incrementButton);
      await tester.pump();
    }
    watch.stop();

    // Verify final count shown
    expect(find.text('20'), findsOneWidget);

    // Soft assertion: taps/updates should be quick
    expect(watch.elapsed.inMilliseconds < 800, isTrue,
        reason: 'Incrementing 20 times should be responsive');

    // Report timings
    final avgMs = (watch.elapsedMilliseconds / 20).toStringAsFixed(1);
    // ignore: avoid_print
  print('Counter: total=${watch.elapsedMilliseconds} ms, avg per increment=$avgMs ms');
  });
}
