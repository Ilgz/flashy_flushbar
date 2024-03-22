import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FlashyFlushbarProvider.init(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flashy Flushbar Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Show a simple FlashyFlushbar
              FlashyFlushbar(
                leadingWidget: const Icon(
                  Icons.error_outline,
                  color: Colors.black,
                  size: 24,
                ),
                message: 'Hello, Flashy Flushbar!',
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.green,
                trailingWidget: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    FlashyFlushbar.cancel();
                  },
                ),
                boxShadows: const [
                  BoxShadow(
                      color: Colors.blue, blurRadius: 4.0, spreadRadius: 2.0),
                ],
              ).show();

              // Show undismissible FlashyFlushbar
              FlashyFlushbar(
                message: 'You can dismiss this!',
                duration: const Duration(seconds: 3),
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
