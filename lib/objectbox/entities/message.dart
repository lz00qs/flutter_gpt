import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'message.g.dart';

List<Message> messageListFromJsonStringList(List<String> jsonStringList) {
  List<Message> messages = [];
  for (String jsonString in jsonStringList) {
    final Message message;
    try {
      message = Message.fromJson(jsonDecode(jsonString));
    } catch (e) {
      debugPrint('messagesFromJsonString: $e');
      continue;
    }
    messages.add(message);
  }
  return messages;
}

List<String> messageListToJsonStringList(List<Message> messages) {
  List<String> messagesJsonString = [];
  for (Message message in messages) {
    final String jsonString;
    try {
      jsonString = jsonEncode(message);
    } catch (e) {
      debugPrint('messagesToJsonString: $e');
      continue;
    }
    messagesJsonString.add(jsonString);
  }
  return messagesJsonString;
}

@JsonSerializable()
class Message {
  final bool isUser;
  final String text;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message({required this.isUser, required this.text});
}