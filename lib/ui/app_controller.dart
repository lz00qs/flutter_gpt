import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../objectbox/entities/chat.dart';
import '../objectbox/entities/message.dart';

class AppController extends GetxController {
  final openAiKey = ''.obs;
  final showTimeStamp = true.obs;
  final showName = true.obs;
  final userName = 'User'.obs;
  final botName = 'Bot'.obs;
  final avatarPath = ''.obs;
  final userAvatarExists = false.obs;
  final botAvatarExists = false.obs;
  final tabIndex = 0.obs;
  final RxList<Message> messages = <Message>[].obs;
  Chat chat = Chat(name: 'empty', timestamp: 'empty', messagesJson: <String>['empty']);

  AppController({iAvatarPath, isUserAvatarExists, isBotAvatarExists}) {
    avatarPath.value = iAvatarPath;
    userAvatarExists.value = isUserAvatarExists;
    botAvatarExists.value = isBotAvatarExists;
    debugPrint('AppConfigController: $avatarPath');
  }
}
