import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

// import 'package:hive_flutter/adapters.dart';
import 'views/home_view/home_view.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return GetX<ThemeController>(
        init: themeController,
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThemeData,
            darkTheme: darkThemeData,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeView(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        });
  }
}
