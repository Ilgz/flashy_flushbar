import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const FlashyFlushbarProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flashy Flushbar Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Show a simple FlashyFlushbar
              FlashyFlushbar(
                message: 'Hello, Flutter!',
                duration: Duration(seconds: 3),
                // Customize other options as needed
              ).show();

              // Show undismissible FlashyFlushbar
              const FlashyFlushbar(
                message: 'You can dismiss this!',
                duration: Duration(seconds: 3),
                dismissDirection: DismissDirection.horizontal,
                isDismissible: false,
              ).show();

              // Cancel the last displayed Flushbar
              Future.delayed(const Duration(seconds: 2), () {
                FlashyFlushbar.cancel();
              });
            },
            child: const Text('Show Flashy Flushbar'),
          ),
        ),
      ),
    );
  }
}
