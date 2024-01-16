import 'package:flutter/widgets.dart';

/// The `FlashyProxy` class is an abstract class that serves as a proxy to hold
/// the build context for the `FlashyFlushbar` widget. It provides a static
/// [BuildContext] variable, [buildContext], which is set by the
/// `FlashyFlushbarProvider` to ensure that the correct build context is
/// accessible to the `FlashyFlushbar` widget.
///
/// Additionally, the [entries] property is a static map that associates
/// [Key] objects with corresponding [OverlayEntry] objects. This map is used
/// internally to keep track of the overlay entries created for each instance
/// of `FlashyFlushbar`.
///
/// This class is marked as `@protected` to indicate that it is intended for
/// internal use within the `flashy_flushbar` package and should not be
/// directly accessed or extended by external code.
@protected
abstract class FlashyProxy {
  /// The static build context variable that holds the build context for the
  /// `FlashyFlushbar` widget.
  static BuildContext? buildContext;

  /// A static map associating [Key] objects with corresponding [OverlayEntry]
  /// objects for each instance of `FlashyFlushbar`.
  ///
  /// This map is used internally to keep track of the overlay entries created
  /// for each `FlashyFlushbar` instance. It is mainly used for canceling and
  /// managing the displayed flushbars.
  static final Map<Key, OverlayEntry> entries = {};
}
