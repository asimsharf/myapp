# myapp

A new Flutter project.

# Getting Started

## Below is the command to create a new Flutter project with the name myapp and the language as Dart (default), using the flutter create command, as shown below:

# Open the terminal and type the following command

```bash
flutter create myapp
```

## To run the app, use the flutter run command, as shown below:

```bash
flutter run
```

* To add a dependency to pubspec.yaml, we can use the following command


```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.3.8
```

* [get: ^4.3.8] GetX is a powerful library that allows you to create reactive applications. It is a wrapper around the Observer pattern, which allows you to listen to changes in the data and update the UI accordingly. It is a great way to speed up your development process.

* [get_cli] I will Use get_cli is a command line tool that helps you create GetX projects, generate pages, controllers, bindings, and more. It is a great way to speed up your development process.

* To Activate the get_cli, use the following command

```bash
flutter pub global activate get_cli
```

* To Export the path, use the following command

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

* To initialize the get_cli, use the following command

```bash
get init
```

* GetX folder structure

```bash
lib
├── app
│   ├── data
│   │
│   ├── modules
│   │   ├── home
│   │   │   ├── bindings
│   │   │   │   └── home_binding.dart
│   │   │   ├── controllers
│   │   │   │   └── home_controller.dart
│   │   │   ├── views
│   │   │   │   └── home_view.dart
│   │   │   └── home_module.dart
│   │   │
│   ├── routes
│   │   └── app_pages.dart
│   │   └── app_routes.dart
│   │
...
```
# Implementation without GetX

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tap Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

/// This is a simple app that records taps and then plays them back.
/// The user can tap the button to record a tap, or long press the button
/// to play back the recorded taps.
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// The number of taps.
  int theTapCount = 0;

  /// The list of tap times.
  final List<int> theTapDelays = [];

  /// Whether the app is recording taps.
  bool theIsRecording = false;

  /// The color of the button changes depending on whether the app is recording taps.
  Color get theButtonColor {
    /// If the app is recording taps, return red.
    if (theIsRecording) {
      return Colors.red;
    }

    /// If the app is not recording taps, return blue.
    return Colors.blue;
  }

  /// Records a tap.
  void theRecordTap() {
    /// If the app is recording taps, add the current time to the list of tap times.
    if (theIsRecording) {
      /// Get the current time.
      int currentTime = DateTime.now().millisecondsSinceEpoch;

      /// If the list of tap times is not empty.
      if (theTapDelays.isNotEmpty) {
        /// Add the difference between the current time and the last time to the list of tap times.
        theTapDelays.add(currentTime - theTapDelays.last);
      }

      /// Add the current time to the list of tap times.
      theTapDelays.add(currentTime);
    } else {
      /// If the app is not recording taps, increment the tap count.
      setState(() {
        theTapCount++;
      });
    }
  }

  /// Plays back the recorded taps.
  void theIncrementCount() {
    setState(() {
      /// Set the app to not recording taps.
      theIsRecording = false;

      /// If the list of tap times is not empty.
      if (theTapDelays.isNotEmpty) {
        /// Add the difference between the current time and the last time to the list of tap times.
        theTapDelays.add(
          DateTime.now().millisecondsSinceEpoch - theTapDelays.last,
        );
      }

      /// For each tap time in the list of tap times.
      for (int i = 0; i < theTapDelays.length; i++) {
        /// Get the tap time.
        int delay = theTapDelays[i];

        /// Wait for the tap time.
        Future.delayed(Duration(milliseconds: delay), () {
          setState(() {
            /// Increment the tap count.
            theTapCount++;
          });
        });
      }

      /// Clear the list of tap times.
      theTapDelays.clear();
    });
  }

  /// Clears the tap count.
  void theStartRecording() {
    setState(() {
      /// Clear the tap count.
      theTapCount = 0;

      /// Clear the list of tap times.
      theTapDelays.clear();

      /// Set the app to recording taps.
      theIsRecording = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// The number of taps.
            Text(
              'Tap Count: $theTapCount',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),

            /// The button to clear the tap count.
            ElevatedButton(
              onPressed: theStartRecording,
              child: const Text('Start Recording'),
            ),
          ],
        ),
      ),

      /// The button to record a tap.
      floatingActionButton: GestureDetector(
        /// The button to play back the recorded taps.
        onLongPress: theIncrementCount,
        child: FloatingActionButton(
          onPressed: theRecordTap,

          /// The color of the button.
          backgroundColor: theButtonColor,
          child: const Icon(Icons.touch_app),
        ),
      ),
    );
  }
}
```

# Implementation with GetX

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "myapp",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
```

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

/// This is a simple app that records taps and then plays them back.
/// The user can tap the button to record a tap, or long press the button
/// to play back the recorded taps.
class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Tap Recorder',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// The number of taps.
            /// Obx is a GetX widget that listens to theTapCount
            /// and rebuilds the widget when theTapCount changes.
            /// This is a much more efficient way to update the UI
            Obx(
              () => Text(
                'Tap Count: ${controller.theTapCount}',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              /// The button to clear the tap count.
              onPressed: controller.theStartRecording,
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
              child: const Text('Start Recording'),
            ),
          ],
        ),
      ),

      /// The button to record a tap.
      floatingActionButton: Obx(
        () => GestureDetector(
          /// The button to play back the recorded taps.
          onLongPress: controller.thePlayBackTaps,
          child: FloatingActionButton(
            /// The button to record a tap.
            onPressed: controller.theRecordTap,

            /// The color of the button.
            /// theButtonColor is an Rx<Color> that is updated
            backgroundColor: controller.theButtonColor,
            child: const Icon(Icons.touch_app),
          ),
        ),
      ),
    );
  }
}
```

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// The number of taps.
  final RxInt theTapCount = 0.obs;

  /// The list of tap times.
  final RxList<int> theTapDelays = <int>[].obs;

  /// Whether the app is recording taps.
  final RxBool theIsRecording = false.obs;

  /// Records a tap.
  void theRecordTap() {
    /// If the app is recording taps, add the current time to the list of tap times.
    if (theIsRecording.value) {
      /// Get the current time.
      final theCurrentTime = DateTime.now().millisecondsSinceEpoch;

      /// If the list of tap times is not empty.
      if (theTapDelays.isNotEmpty) {
        /// Add the difference between the current time and the last time to the list of tap times.
        theTapDelays.add(theCurrentTime - theTapDelays.last);
      }

      /// Add the current time to the list of tap times.
      theTapDelays.add(theCurrentTime);
    } else {
      /// If the app is not recording taps, increment the tap count.
      theTapCount.value++;
    }
  }

  /// Plays back the recorded taps.
  void thePlayBackTaps() {
    /// Set the app to not recording taps.
    theIsRecording.value = false;

    /// If the list of tap times is not empty.
    if (theTapDelays.isNotEmpty) {
      /// Add the difference between the current time and the last time to the list of tap times.
      theTapDelays.add(
        DateTime.now().millisecondsSinceEpoch - theTapDelays.last,
      );
    }

    /// For each tap time, increment the tap count after the specified delay.
    for (var i = 0; i < theTapDelays.length; i++) {
      /// Get the tap time.
      final theDelay = theTapDelays[i];

      /// Increment the tap count after the specified delay.
      Future.delayed(Duration(milliseconds: theDelay), () {
        /// Increment the tap count.
        theTapCount.value++;
      });
    }

    /// Clear the list of tap times.
    theTapDelays.clear();
  }

  /// Starts recording taps.
  void theStartRecording() {
    /// Clear the tap count.
    theTapCount.value = 0;

    /// Clear the list of tap times.
    theTapDelays.clear();

    /// Set the app to recording taps.
    theIsRecording.value = true;
  }

  /// Gets the button color. If the app is recording taps, the button color is red. Otherwise, the button color is blue.
  Color get theButtonColor => theIsRecording.value ? Colors.red : Colors.blue;
}
```