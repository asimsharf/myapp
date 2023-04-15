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
