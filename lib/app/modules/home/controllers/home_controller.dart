import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt theTapCount = 0.obs;
  RxList<int> theTapTimes = RxList<int>([]);

  void recordTap() {
    theTapTimes.add(DateTime.now().millisecondsSinceEpoch);
  }

  void incrementTaps() {
    int prevTime = 0;
    for (var time in theTapTimes) {
      Future.delayed(Duration(milliseconds: time - prevTime)).then((_) {
        theTapCount++;
      });
      prevTime = time;
    }
  }

  void clearTaps() {
    theTapCount.value = 0;
    theTapTimes.clear();
  }

  @override
  void onInit() {
    ever(theTapTimes, (_) => incrementTaps());
    super.onInit();
  }
}
