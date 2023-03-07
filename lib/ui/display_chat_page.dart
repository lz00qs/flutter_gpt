import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../objectbox/entities/chat.dart';
import '../objectbox/entities/message.dart';
import 'app_controller.dart';

class DisplayChatPage extends GetView<AppController> {
  const DisplayChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: ListTile(
          title: Text(controller.chat.name),
          subtitle: Text(controller.chat.timestamp),
        )),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              chatListBuilder(
                  messageListFromJsonStringList(controller.chat.messagesJson)
                      .obs,
                  controller),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}
