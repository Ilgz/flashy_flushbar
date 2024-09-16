import 'dart:async';

import 'package:flashy_flushbar/flashy_proxy.dart';
import 'package:flutter/material.dart';

/// `FlashyFlushbar` is a customizable and animated Flutter widget for displaying
/// informative messages to users. It provides a sleek and visually appealing way
/// to convey messages, warnings, or notifications.
///
/// To use `FlashyFlushbar`, create an instance of this class and customize its
/// properties such as duration, message, style, and appearance. Then, call the
/// `show()` method to display the flushbar.
class FlashyFlushbar extends StatefulWidget {
  /// Constructs a `FlashyFlushbar` widget with customizable properties.
  ///
  /// The `key` parameter is inherited from the `StatefulWidget` class.
  ///
  /// The `duration` parameter sets the duration for which the flushbar will be
  /// displayed. The default duration is one second.
  ///
  /// The `message` parameter is the text message to be displayed by the flushbar.
  ///
  /// The `messageStyle` parameter is the style of the text message, including
  /// color and font size. The default style is black text with a font size of 16.
  ///
  /// The `margin` parameter is the margin around the flushbar. The default margin
  /// is 32 pixels on the left, right, and 20 pixels on the top.
  ///
  /// The `backgroundColor` parameter sets the background color of the flushbar.
  /// The default color is white.
  ///
  /// The `boxShadows` parameter defines the box shadow for the flushbar. The
  /// default is a subtle box shadow.
  ///
  /// The `borderRadius` parameter sets the border radius of the flushbar. The
  /// default is a circular border with a radius of 16 pixels.
  ///
  /// The `height` parameter sets the height of the flushbar. The default height
  /// is 64 pixels.
  ///
  /// The `animationDuration` parameter defines the duration of the animation
  /// when showing and hiding the flushbar. The default duration is 500 milliseconds.
  ///
  /// The `leadingWidget` parameter is a widget to be displayed on the left side
  /// of the flushbar. The default is an empty `SizedBox`.
  ///
  /// The `trailingWidget` parameter is a widget to be displayed on the right side
  /// of the flushbar. The default is an empty `SizedBox`.
  ///
  /// The `messageHorizontalSpacing` parameter sets the spacing between the message
  /// and the leading/trailing widgets. The default is 8 pixels.
  ///
  /// The `horizontalPadding` parameter defines the horizontal padding of the
  /// flushbar. The default is padding of 16 pixels on both sides.
  ///
  /// The `dismissDirection` parameter defines the direction in which the flushbar
  /// can be dismissed. The default is horizontal dismissal.
  ///
  /// The `onTap` parameter is a callback function to be executed when the flushbar
  /// is tapped. If provided, tapping the flushbar will execute this callback and
  /// hide the flushbar.
  FlashyFlushbar({
    this.duration = const Duration(seconds: 1),
    this.message = '',
    this.messageStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
    this.margin = const EdgeInsets.only(left: 32, right: 32, top: 20),
    this.backgroundColor = Colors.white,
    this.boxShadows = const [
      BoxShadow(
        color: Color(0x1a000000),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.height = 64,
    this.animationDuration = const Duration(milliseconds: 500),
    this.leadingWidget = const SizedBox(),
    this.trailingWidget = const SizedBox(),
    this.messageHorizontalSpacing = 8,
    this.horizontalPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.dismissDirection = DismissDirection.horizontal,
    this.onTap,
    this.isDismissible = true,
    this.comingFromTop = true,
    this.customWidget,
  }) : super(key: UniqueKey());

  /// The duration for which the flushbar will be displayed.
  final Duration duration;

  /// The text message to be displayed by the flushbar.
  final String message;

  /// The style of the text message, including color and font size.
  final TextStyle messageStyle;

  /// The margin around the flushbar.
  final EdgeInsets margin;

  /// The background color of the flushbar.
  final Color backgroundColor;

  /// The box shadows for the flushbar.
  final List<BoxShadow>? boxShadows;

  /// The border radius of the flushbar.
  final BorderRadiusGeometry borderRadius;

  /// The height of the flushbar.
  final double height;

  /// The duration of the animation when showing and hiding the flushbar.
  final Duration animationDuration;

  /// A widget to be displayed on the left side of the flushbar.
  final Widget leadingWidget;

  /// A widget to be displayed on the right side of the flushbar.
  final Widget trailingWidget;

  /// The spacing between the message and the leading/trailing widgets.
  final double messageHorizontalSpacing;

  /// The horizontal padding of the flushbar.
  final EdgeInsets horizontalPadding;

  /// The direction in which the flushbar can be dismissed.
  final DismissDirection dismissDirection;

  /// A callback function to be executed when the flushbar is tapped.
  final VoidCallback? onTap;

  /// A flag indicating whether the flushbar can be dismissed.
  ///
  /// If set to `true`, the flushbar can be dismissed by the user. The dismiss
  /// action can be triggered by swiping in the direction specified by
  /// [dismissDirection], or by tapping on the flushbar if [onTap] is provided.
  ///
  /// If set to `false`, the flushbar will not be dismissible, and user actions
  /// such as swiping or tapping will have no effect.
  ///
  /// The default value is `true`.
  final bool isDismissible;

  /// If true, the flushbar will animate from the top of the screen, otherwise it will animate from the bottom.
  final bool comingFromTop;

  ///
  /// If [customWidget] is provided, other properties such as [leadingWidget],
  /// [message], [trailingWidget], [messageStyle], etc., will be ignored.
  final Widget? customWidget;

  @override
  State<FlashyFlushbar> createState() => _FlashyFlushbarState();

  /// Displays the flushbar by creating an overlay entry.
  ///
  /// The flushbar will be removed automatically after the specified duration.
  /// If `onTap` is provided, tapping the flushbar will execute the callback and hide the flushbar.
  void show() {
    final overlay = OverlayEntry(builder: (BuildContext context) {
      return this;
    });
    if (FlashyProxy.buildContext == null) {
      throw Exception("FlashyProxy.buildContext is null, please use FlashyFlushbarProvider");
    }

    Overlay.of(FlashyProxy.buildContext!, debugRequiredFor: this).insert(overlay);
    FlashyProxy.entries[key!] = overlay;
  }

  /// Cancels the last displayed flushbar.
  ///
  /// If there are no flushbars currently displayed, this method has no effect.
  /// This method removes the last displayed flushbar, effectively hiding it
  /// from the screen.
  ///
  /// Throws an exception if [FlashyProxy.buildContext] is null.
  static void cancel() {
    if (FlashyProxy.buildContext == null) {
      throw Exception("FlashyProxy.buildContext is null, please use FlashyFlushbarProvider");
    }
    if (FlashyProxy.entries.isEmpty) return;
    final lastOverlayEntry = FlashyProxy.entries.values.last;
    if (lastOverlayEntry.mounted) {
      lastOverlayEntry.remove();
    }
    FlashyProxy.entries.remove(FlashyProxy.entries.keys.last);
  }

  /// Cancels all displayed flushbars.
  ///
  /// This method removes all currently displayed flushbars, effectively
  /// hiding them from the screen.
  ///
  /// Throws an exception if [FlashyProxy.buildContext] is null.
  static void cancelAll() {
    if (FlashyProxy.buildContext == null) {
      throw Exception("FlashyProxy.buildContext is null, please use FlashyFlushbarProvider");
    }
    for (final overlayEntry in FlashyProxy.entries.values) {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    }
    FlashyProxy.entries.clear();
  }
}

class _FlashyFlushbarState extends State<FlashyFlushbar> with SingleTickerProviderStateMixin {
  double get toastHeight => widget.height;

  double get fullHeight => toastHeight + widget.margin.top + widget.margin.bottom;

  double get fullWidth =>
      MediaQuery.of(context).size.width - (widget.margin.left + widget.margin.right);

  late final animationController =
      AnimationController(vsync: this, duration: widget.animationDuration);
  Timer? _hideTimer;
  Timer? _removeTimer;

  @override
  void initState() {
    _hideTimer = Timer(widget.duration + widget.animationDuration, () {
      if (mounted) {
        animationController.reverse();
      }
    });
    _removeTimer = Timer(widget.duration + (widget.animationDuration * 2), () {
      _removeFlushbarFromOverlay();
    });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _hideTimer?.cancel();
    _removeTimer?.cancel();
    super.dispose();
  }

  void _removeFlushbarFromOverlay() {
    final entry = FlashyProxy.entries.remove(widget.key);
    entry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      child: SafeArea(
        child: Align(
          alignment: widget.comingFromTop ? Alignment.topCenter : Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            key: const ValueKey('flashy_flushbar_gesture_key'),
            onTap: widget.onTap != null
                ? () {
                    widget.onTap!();
                    _removeFlushbarFromOverlay();
                  }
                : null,
            child: SizedBox(
              height: fullHeight,
              child: _DismissibleWrapper(
                dismissDirection: widget.dismissDirection,
                isDismissible: widget.isDismissible,
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Stack(
                      children: [
                        Positioned(
                          bottom: widget.comingFromTop
                              ? null
                              : (fullHeight * animationController.value) - (fullHeight),
                          top: widget.comingFromTop
                              ? (fullHeight * animationController.value) - (fullHeight)
                              : null,
                          child: Container(
                            width: fullWidth,
                            height: toastHeight,
                            margin: widget.margin,
                            decoration: BoxDecoration(
                              color: widget.backgroundColor,
                              boxShadow: widget.boxShadows,
                              borderRadius: widget.borderRadius,
                            ),
                            padding: EdgeInsets.only(
                              left: widget.horizontalPadding.left,
                              right: widget.horizontalPadding.right,
                            ),
                            child: widget.customWidget ??
                                Row(
                                  children: [
                                    widget.leadingWidget,
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: widget.messageHorizontalSpacing),
                                        child: Text(
                                          widget.message,
                                          style: widget.messageStyle,
                                        ),
                                      ),
                                    ),
                                    widget.trailingWidget,
                                  ],
                                ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DismissibleWrapper extends StatelessWidget {
  const _DismissibleWrapper({
    required this.child,
    required this.isDismissible,
    required this.dismissDirection,
  });

  final Widget child;
  final bool isDismissible;
  final DismissDirection dismissDirection;

  @override
  Widget build(BuildContext context) {
    return isDismissible
        ? Dismissible(
            key: UniqueKey(),
            direction: dismissDirection,
            child: child,
          )
        : child;
  }
}
