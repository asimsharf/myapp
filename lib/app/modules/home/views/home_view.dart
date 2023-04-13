import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
            const Text('Number of Taps'),
            Obx(
              () => Text(
                '${controller.theTapCount.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.clearTaps(),
              child: const Text('Clear Taps'),
            ),
            const SizedBox(height: 20),
            const Text('Tap the button to record a tap.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.recordTap(),
        child: const Icon(Icons.touch_app),
      ),
    );
  }
}
