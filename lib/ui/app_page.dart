import 'package:flutter/material.dart';
import 'package:flutter_gpt/ui/app_controller.dart';
import 'package:flutter_gpt/ui/saved_chats_body.dart';
import 'package:flutter_gpt/ui/settings_body.dart';
import 'package:get/get.dart';

import 'chat_body.dart';

class AppPage extends GetView<AppController> {
  AppPage({super.key});

  final chatBody = const ChatBody();
  final savedChatsBody = const SavedChatsBody();
  final settingsBody = SettingsBody();

  @override
  Widget build(BuildContext context) {
    // Get.put(_BodyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GPT'),
      ),
      body: Obx(() {
        switch (controller.tabIndex.value) {
          case 0:
            return chatBody;
          case 1:
            return savedChatsBody;
          case 2:
            return settingsBody;
          default:
            return chatBody;
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          onTap: (index) {
            controller.tabIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Saved Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
