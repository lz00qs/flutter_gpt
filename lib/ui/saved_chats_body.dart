import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../objectbox/objectbox.dart';
import 'app_controller.dart';

class SavedChatsBody extends GetView<AppController> {
  SavedChatsBody({super.key});

  final objectbox = Get.find<ObjectBox>();

  @override
  Widget build(BuildContext context) {
    final chats = objectbox.getSavedChats().obs;
    return SelectionArea(
      child: Obx(
        () => ListView.builder(
          reverse: false,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              title: Text(chat.name),
              subtitle: Text(chat.timestamp),
              onLongPress: () {
                Get.defaultDialog(
                  title: 'Delete Chat',
                  content:
                      const Text('Are you sure you want to delete this chat?'),
                  textCancel: 'Cancel',
                  textConfirm: 'Delete',
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    if (objectbox.deleteChat(chat)) {
                      chats.value = objectbox.getSavedChats();
                    }
                    Get.back();
                  },
                );
              },
              onTap: () {
                controller.chat = chat;
                Get.toNamed('/displayChatPage');
              },
            );
          },
        ),
      ),
    );
  }
}
