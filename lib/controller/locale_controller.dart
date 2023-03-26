import 'dart:ui';

import 'package:get/get.dart';

class LocaleController extends GetxController {
  var englishLocale = true.obs;

  void changeLanguage() {
    if (englishLocale == true.obs) {
      Get.updateLocale(const Locale('vi','VN'));
    } else {
      Get.updateLocale(const Locale('en','US'));
    }
    englishLocale.value = !englishLocale.value;
  }
}
