import 'package:get/get.dart';

class SpeakerController extends GetxController {
  var autoRead = true.obs;

  void changeReadMode() {
    autoRead.value = !autoRead.value;
  }
}
