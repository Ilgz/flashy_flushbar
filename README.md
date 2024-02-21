[![codecov](https://codecov.io/gh/Ilgz/flashy_flushbar/graph/badge.svg?token=PGCF6JHRAO)](https://codecov.io/gh/Ilgz/flashy_flushbar)

# Flashy Flushbar

A highly customizable, dismissible and animated flushbar (toast) for Flutter applications.

## Features

- Customize the appearance with various options.
- Animated entrance and exit transitions.
- Support for dismissible flushbars.
- Easily show and hide flushbars programmatically.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flashy_flushbar: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:flashy_flushbar/flashy_flushbar.dart';
```

To make the context accessible, specify FlashyFlushbarProvider in the builder of your MaterialApp:

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // here
      builder: FlashyFlushbarProvider.init(),
    );
  }
}
```

&nbsp;
 <tr>
    <td><img src="https://raw.githubusercontent.com/Ilgz/flashy_flushbar/main/screenshots/example_1.jpg" height="200"></td>
  </tr>


Now you can use FlashyFlushbar in your Flutter app. Here's a basic example:

```dart
FlashyFlushbar
(
leadingWidget: const Icon(
Icons.error_outline,
color: Colors.black,
size: 24,
),
message: 'Hello from Flashy Flushbar',
duration: const Duration(seconds: 1),
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
isDismissible: false,
).show(
);
```

To cancel the last displayed flushbar:

```dart
FlashyFlushbar.cancel
();
```

To cancel all active flushbars:

```dart
FlashyFlushbar.cancelAll
();
```

## Example

For a complete example, see the `example` folder in this repository.
