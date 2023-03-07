import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_controller.dart';

Widget chatAvatar({required bool isUser}) {
  final controller = Get.find<AppController>();

  return Obx(() => isUser
      ? CircleAvatar(
          backgroundImage: (controller.userAvatarExists.value
                  ? FileImage(File('${controller.avatarPath}/user_avatar'))
                  : const AssetImage("assets/defaultUserAvatar.webp"))
              as ImageProvider)
      : CircleAvatar(
          backgroundImage: (controller.userAvatarExists.value
                  ? FileImage(File('${controller.avatarPath}/bot_avatar'))
                  : const AssetImage("assets/defaultBotAvatar.jpeg"))
              as ImageProvider));
}
