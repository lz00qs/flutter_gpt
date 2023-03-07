import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../objectbox/entities/chat.dart';
import '../objectbox/entities/message.dart';
import '../objectbox/objectbox.dart';
import 'app_controller.dart';

class ChatBody extends GetView<AppController> {
  ChatBody({Key? key}) : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();
  final objectbox = Get.find<ObjectBox>();

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    controller.messages.insert(0, Message(isUser: true, text: text));

    final http.Response response;

    try {
      response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${controller.openAiKey.value}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': text}
          ]
        }),
      );
    } catch (e) {
      controller.messages.insert(0, Message(isUser: false, text: "Error: $e"));
      return;
    }

    // 你好
    var message = '';
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    try {
      message = responseData['choices'][0]['message']['content'];
      debugPrint(responseData.toString());
    } catch (e) {
      message =
          "Check API key in Settings!!!\n${responseData['error']['message']}";
    }

    debugPrint("response: $message");

    controller.messages
        .insert(0, Message(isUser: false, text: message.trimLeft()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        chatListBuilder(controller.messages, controller),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _sendMessage(),
              ),
            ),
            onSubmitted: (_) => _sendMessage(),
          ),
        )
      ],
    );
  }

  void _sendMessage() {
    final text = _textEditingController.text;
    if (text.isNotEmpty) {
      _handleSubmitted(text);
    }
  }
}
