import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigateIndex = 0;

  void changeNavigateIndex(int index) {
    _navigateIndex = index;

    update();
  }

  int get navigateIndex => _navigateIndex;
}
