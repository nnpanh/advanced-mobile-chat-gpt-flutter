import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutgpt/config/pallete.dart';
import 'package:flutgpt/controller/chat_controller.dart';
import 'package:flutgpt/controller/locale_controller.dart';
import 'package:flutgpt/controller/speaker_controller.dart';
import 'package:flutgpt/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Drawer appDrawer(BuildContext context) {
  TextStyle fixedStyle = GoogleFonts.roboto(
    color: Colors.white,
  );
  ThemeController themeController = Get.put(ThemeController());
  ChatController chatController = Get.put(ChatController());
  SpeakerController speakerController = Get.put(SpeakerController());
  LocaleController localeController = Get.put(LocaleController());

  return Drawer(
    backgroundColor: const Color(0xff202123),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: GetBuilder<ChatController>(builder: (chatContext) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: chatController.chats[0].summary!.isNotEmpty,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: chatController.chats.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: activeColor),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    chatController.changeConversation(index);
                                    Get.back();
                                  },
                                  leading: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    chatController
                                            .chats[index].summary!.isNotEmpty
                                        ? chatController.chats[index].summary!
                                        : AppLocalizations.of(context)!.newChat,
                                    style: fixedStyle,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Visibility(
                      visible: chatController
                              .chats[chatController.chats.length - 1]
                              .summary!
                              .isNotEmpty ||
                          chatController.chats.length == 1,
                      child: GestureDetector(
                        onTap: () {
                          chatController.addChat();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: activeColor),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            title: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              AppLocalizations.of(context)!.newChat,
                              style: fixedStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 1,
                  color: activeColor,
                ),
                ListTile(
                  onTap: () => chatController.clearConversation(),
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  title: Text(AppLocalizations.of(context)!.clearChat, style: fixedStyle),
                ),
                Obx(
                  () {
                    return ListTile(
                      onTap: () => themeController.changeThemeMode(),
                      leading: Icon(
                        themeController.isDarkMode.value
                            ? Icons.wb_sunny_outlined
                            : Icons.nightlight_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        themeController.isDarkMode.value
                            ? AppLocalizations.of(context)!.darkMode
                            : AppLocalizations.of(context)!.lightMode,
                        style: fixedStyle,
                      ),
                    );
                  },
                ),
                Obx(
                      () {
                    return ListTile(
                      onTap: () =>speakerController.changeReadMode(),
                      leading: Icon(
                        speakerController.autoRead.value
                            ? Icons.volume_off_rounded
                            : Icons.volume_up_rounded,
                        color: Colors.white,
                      ),
                      title: Text(
                        speakerController.autoRead.value
                            ? AppLocalizations.of(context)!.disableRead
                            : AppLocalizations.of(context)!.enableRead,
                        style: fixedStyle,
                      ),
                    );
                  },
                ),
                Obx(
                      () {
                    return ListTile(
                      onTap: () =>localeController.changeLanguage(),
                      leading: Image.asset(
                        localeController.englishLocale.value
                            ? 'assets/britain.png'
                            : 'assets/vietnam.png',
                        height: 24, width:24
                      ),
                      title: Text(
                        localeController.englishLocale.value
                            ? 'English'
                            : 'Tiếng Việt',
                        style: fixedStyle,
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        );
      }),
    ),
  );
}
