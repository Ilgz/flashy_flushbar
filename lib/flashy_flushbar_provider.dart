import 'package:flashy_flushbar/flashy_proxy.dart';
import 'package:flutter/material.dart';

/// The `FlashyFlushbarProvider` is a Flutter widget that provides the build
/// context to the `FlashyFlushbar` widget. It should be placed at the root of
/// your widget tree, typically above the `MaterialApp` widget.
///
/// By wrapping your app with `FlashyFlushbarProvider`, it ensures that the
/// `FlashyFlushbar` widget can access the correct build context for overlay
/// insertion.
class FlashyFlushbarProvider extends StatefulWidget {
  /// The child widget that will be wrapped by the `FlashyFlushbarProvider`.
  final Widget? child;

  /// Constructs a `FlashyFlushbarProvider` with an optional child widget.
  ///
  /// The `key` parameter is inherited from the `StatefulWidget` class.
  ///
  /// The `child` parameter is an optional widget that will be wrapped by the
  /// `FlashyFlushbarProvider`. If no child is provided, it defaults to an empty
  /// `SizedBox`.
  const FlashyFlushbarProvider({super.key, this.child});

  /// Initializes the `FlashyFlushbarProvider` to provide the build context for
  /// the `FlashyFlushbar` widget.
  ///
  /// This function should be used when wrapping your app with `FlashyFlushbarProvider`
  /// to ensure that the `FlashyFlushbar` widget can access the correct build
  /// context for overlay insertion.
  ///
  /// The `init` function returns a widget function that takes a [BuildContext]
  /// and an optional child widget. It wraps the provided child with the
  /// `FlashyFlushbarProvider` and sets it as a child of the overlay. If no child
  /// is provided, it defaults to an empty [SizedBox].
  ///
  /// Example usage:
  /// ```dart
  ///  void main() => runApp(MyApp());
  ///
  ///  class MyApp extends StatelessWidget {
  ///  @override
  ///  Widget build(BuildContext context) {
  ///  return MaterialApp(
  ///  home: HomePage(),
  ///  // here
  ///  builder: FlashyFlushbarProvider.init(),
  ///  );
  ///  }
  ///  }
  /// ```

  static Widget Function(BuildContext context, Widget? child)? init() {
    return (context, child) => FlashyFlushbarProvider(child: child);
  }

  @override
  State<FlashyFlushbarProvider> createState() => _FlashyFlushbarProviderState();
}

class _FlashyFlushbarProviderState extends State<FlashyFlushbarProvider> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              FlashyProxy.buildContext = context;
              return widget.child ?? const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
