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
