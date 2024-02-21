import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const animationDuration = Duration(milliseconds: 500);
  const duration = Duration(seconds: 1);
  final overallDuration = (animationDuration * 2) + (duration) + const Duration(milliseconds: 300);
  testWidgets('FlashyFlushbar Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      builder: FlashyFlushbarProvider.init(),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                FlashyFlushbar(
                  message: 'Test Message',
                  duration: Duration(seconds: 1),
                ).show();
              },
              child: const Text('Show FlashyFlushbar'),
            );
          },
        ),
      ),
    ));
    // Tap the button to trigger the flushbar
    await tester.tap(find.text('Show FlashyFlushbar'));
    await tester.pumpAndSettle(animationDuration);
    // Expect to find the message in the widget tree
    expect(find.text('Test Message'), findsOneWidget);
    // Wait for the flushbar to disappear
    await tester.pump(overallDuration);
    expect(find.text('Test Message'), findsNothing);
  });

  testWidgets('Test show method throws exception', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () {
              // Ensure an exception is thrown when show() is called
              expect(() {
                FlashyFlushbar(message: 'Test Message').show();
              },
                  throwsA(isA<Exception>().having(
                    (e) => e.toString(),
                    'message',
                    'FlashyProxy.buildContext is null, please use FlashyFlushbarProvider',
                  )));
            },
            child: const Text('Show FlashyFlushbar'),
          );
        },
      ),
    ));
  });
  testWidgets('Test cancel method throws exception', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () {
              // Ensure an exception is thrown when cancel() is called
              expect(() {
                FlashyFlushbar.cancel();
              },
                  throwsA(isA<Exception>().having(
                    (e) => e.toString(),
                    'message',
                    'FlashyProxy.buildContext is null, please use FlashyFlushbarProvider',
                  )));
            },
            child: const Text('Cancel FlashyFlushbar'),
          );
        },
      ),
    ));
  });
  testWidgets('Test cancelAll method throws exception', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () {
              // Ensure an exception is thrown when cancelAll() is called
              expect(() {
                FlashyFlushbar.cancelAll();
              },
                  throwsA(isA<Exception>().having(
                    (e) => e.toString(),
                    'message',
                    'FlashyProxy.buildContext is null, please use FlashyFlushbarProvider',
                  )));
            },
            child: const Text('Cancel All FlashyFlushbars'),
          );
        },
      ),
    ));
  });

  testWidgets('Test cancel method removes last overlay entry', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      builder: FlashyFlushbarProvider.init(),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                FlashyFlushbar(
                  message: 'Test Message',
                  duration: duration,
                  animationDuration: animationDuration,
                ).show();
              },
              child: const Text('Show FlashyFlushbar'),
            );
          },
        ),
      ),
    ));
    // Tap the button to trigger the flushbar
    await tester.tap(find.text('Show FlashyFlushbar'));
    await tester.pump(animationDuration);
    // Expect to find the message in the widget tree
    expect(find.text('Test Message'), findsOneWidget);
    // Call the cancel method to remove the flushbar
    FlashyFlushbar.cancel();
    await tester.pump();
    // Expect the message to be removed from the widget tree
    expect(find.text('Test Message'), findsNothing);
  });
  testWidgets('Test cancelAll method removes all overlay entries', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      builder: FlashyFlushbarProvider.init(),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                FlashyFlushbar(
                  message: 'Test Message 1',
                  duration: duration,
                  animationDuration: animationDuration,
                ).show();
                FlashyFlushbar(
                  message: 'Test Message 2',
                  duration: duration,
                  animationDuration: animationDuration,
                ).show();
              },
              child: const Text('Show FlashyFlushbars'),
            );
          },
        ),
      ),
    ));

    // Tap the button to trigger the flushbars
    await tester.tap(find.text('Show FlashyFlushbars'));
    await tester.pump(animationDuration);

    // Expect to find the messages in the widget tree
    expect(find.text('Test Message 1'), findsOneWidget);
    expect(find.text('Test Message 2'), findsOneWidget);

    // Call the cancelAll method to remove all flushbars
    FlashyFlushbar.cancelAll();
    await tester.pump();

    // Expect both messages to be removed from the widget tree
    expect(find.text('Test Message 1'), findsNothing);
    expect(find.text('Test Message 2'), findsNothing);
  });

  testWidgets('Test onTap triggers callback and dismisses flushbar', (tester) async {
    bool onTapCalled = false;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      builder: FlashyFlushbarProvider.init(),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                FlashyFlushbar(
                  message: 'Test Message',
                  duration: duration,
                  animationDuration: animationDuration,
                  onTap: () {
                    onTapCalled = true;
                  },
                ).show();
              },
              child: const Text('Show FlashyFlushbar'),
            );
          },
        ),
      ),
    ));

    // Tap the button to trigger the flushbar
    await tester.tap(find.text('Show FlashyFlushbar'));
    await tester.pump(animationDuration);

    // Expect to find the message in the widget tree
    expect(find.text('Test Message'), findsOneWidget);
    await tester.pumpAndSettle();
    // Tap the flushbar to trigger onTap
    await tester.tap(find.byKey(const ValueKey('flashy_flushbar_gesture_key')));
    await tester.pump();

    // Expect onTap callback to be called
    expect(onTapCalled, true);
    await tester.pump(overallDuration);
    // Expect the message to be removed from the widget tree
    expect(find.text('Test Message'), findsNothing);
  });
}
