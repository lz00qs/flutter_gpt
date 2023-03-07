import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';

import '../../ui/app_controller.dart';
import '../../ui/utils.dart';
import '../../ui/widgets/chat_avatar.dart';
import 'message.dart';

@Entity()
class Chat {
  @Id()
  int id = 0;
  String name;
  String timestamp;
  List<String> messagesJson;

  Chat(
      {this.id = 0,
      required this.name,
      required this.timestamp,
      required this.messagesJson});
}

Widget chatListBuilder(RxList<Message> messages, AppController controller) {
  Widget chatBubble(Message message) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Column(children: [
          message.isUser
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        controller.showName.value
                            ? Text(controller.userName.value,
                                style: const TextStyle(fontSize: 12))
                            : const SizedBox(),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Bubble(
                          color: const Color(0xFF1B97F3),
                          child: Text(
                            message.text,
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        controller.showTimeStamp.value
                            ? Text(
                                timeStamp(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              )
                            : const SizedBox(),
                      ],
                    )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    chatAvatar(isUser: message.isUser), // isUser
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    chatAvatar(isUser: message.isUser), // isNotUser
                    const SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.showName.value
                              ? Text(controller.botName.value,
                                  style: const TextStyle(fontSize: 12))
                              : const SizedBox(),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Bubble(
                            color: const Color(0xFFE8E8EE),
                            child: Text(
                              message.text,
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          controller.showTimeStamp.value
                              ? Text(
                                  timeStamp(),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                )
        ]));
  }

  return Flexible(
    child: Obx(
      () => SelectionArea(
        child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return chatBubble(message);
          },
        ),
      ),
    ),
  );
}
