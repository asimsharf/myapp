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
