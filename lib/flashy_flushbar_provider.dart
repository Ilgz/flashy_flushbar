library flashy_flushbar;

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
