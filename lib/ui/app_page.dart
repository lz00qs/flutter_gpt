import 'package:flutter/material.dart';
import 'package:flutter_gpt/ui/app_controller.dart';
import 'package:flutter_gpt/ui/saved_chats_body.dart';
import 'package:flutter_gpt/ui/settings_body.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../objectbox/entities/message.dart';
import 'chat_body.dart';

void _saveChat(String chatName, List<Message> messages) {
  final List<String> messageJsonList = messageListToJsonStringList(messages);
  if (messageJsonList.isNotEmpty) {
    objectbox.saveChat(chatName, messageJsonList);
  }
  debugPrint(messageJsonList.toString());
}

class AppPage extends GetView<AppController> {
  AppPage({super.key});

  final chatBody = ChatBody();
  final savedChatsBody = const SavedChatsBody();
  final settingsBody = SettingsBody();
  final chatNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get.put(_BodyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter GPT'),
        actions: [
          Obx(() => controller.tabIndex.value == 0
              ? ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  // icon: const Icon(Icons.refresh),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.refresh),
                      Text(
                        "Reset",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Reset Chat',
                      content:
                          const Text('Are you sure you want to reset chat?'),
                      textConfirm: 'Reset',
                      textCancel: 'Cancel',
                      onConfirm: () {
                        controller.messages.clear();
                        Get.back();
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                )
              : const SizedBox.shrink()),
          Obx(() => controller.tabIndex.value == 0
              ? ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  // icon: const Icon(Icons.refresh),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.save),
                      Text(
                        "Save",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Save Chat',
                      content: TextField(
                        controller: chatNameEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Enter chat name',
                        ),
                        onChanged: (value) {
                          // openAIKey.value = value;
                        },
                      ),
                      textConfirm: 'Save',
                      textCancel: 'Cancel',
                      onConfirm: () {
                        if (chatNameEditingController.text.isNotEmpty) {
                          _saveChat(chatNameEditingController.text,
                              controller.messages);
                          Get.back();
                        }
                      },
                      onCancel: () {
                        Get.back();
                      },
                    );
                  },
                )
              : const SizedBox.shrink()),
        ],
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
