import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gpt/ui/app_controller.dart';
import 'package:flutter_gpt/ui/widgets/chat_avatar.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../objectbox/entities/app_config.dart';
import '../objectbox/objectbox.dart';

class SettingsBody extends GetView<AppController> {
  SettingsBody({Key? key}) : super(key: key);

  final objectbox = Get.find<ObjectBox>();
  final apiKeyEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final botNameEditingController = TextEditingController();

  int _saveConfig(String? openAiKey, bool? showTimeStamp, bool? showName,
      String? userName, String? botName) {
    final appConfig = objectbox.getConfig();
    if (appConfig != null) {
      if (openAiKey != null) {
        appConfig.openAiKey = openAiKey;
      }
      if (showTimeStamp != null) {
        appConfig.showTimeStamp = showTimeStamp;
      }
      if (showName != null) {
        appConfig.showName = showName;
      }
      if (userName != null) {
        appConfig.userName = userName;
      }
      if (botName != null) {
        appConfig.botName = botName;
      }
      return objectbox.saveConfig(appConfig);
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    apiKeyEditingController.text = controller.openAiKey.value;
    userNameEditingController.text = controller.userName.value;
    botNameEditingController.text = controller.botName.value;

    return ListView(
      children: [
        ListTile(
          title: const Text('OpenAI API Key'),
          subtitle: Obx(() => Text(controller.openAiKey.value)),
          onTap: () {
            Get.defaultDialog(
              title: 'Edit OpenAI API Key',
              content: TextField(
                controller: apiKeyEditingController,
                onChanged: (value) {
                  // openAIKey.value = value;
                },
              ),
              onConfirm: () {
                if (_saveConfig(
                        apiKeyEditingController.text, null, null, null, null) ==
                    1) {
                  controller.openAiKey.value = apiKeyEditingController.text;
                }
                Get.back();
              },
              onCancel: () => Get.back(),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Show Name'),
          trailing: Obx(
            () => Switch(
              value: controller.showName.value,
              onChanged: (isCheck) {
                if (_saveConfig(null, null, isCheck, null, null) == 1) {
                  controller.showName.value = isCheck;
                }
              },
            ),
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('Show Time Stamp'),
          trailing: Obx(
            () => Switch(
              value: controller.showTimeStamp.value,
              onChanged: (isCheck) {
                if (_saveConfig(null, isCheck, null, null, null) == 1) {
                  controller.showTimeStamp.value = isCheck;
                }
              },
            ),
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text('User Name'),
          subtitle: Obx(() => Text(controller.userName.value)),
          onTap: () {
            Get.defaultDialog(
              title: 'Edit user name',
              content: TextField(
                controller: userNameEditingController,
                onChanged: (value) {
                  // openAIKey.value = value;
                },
              ),
              onConfirm: () {
                if (_saveConfig(null, null, null,
                        userNameEditingController.text, null) ==
                    1) {
                  controller.userName.value = userNameEditingController.text;
                }

                Get.back();
              },
              onCancel: () => Get.back(),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Bot Name'),
          subtitle: Obx(() => Text(controller.botName.value)),
          onTap: () {
            Get.defaultDialog(
              title: 'Edit bot name',
              content: TextField(
                controller: botNameEditingController,
                onChanged: (value) {
                  // openAIKey.value = value;
                },
              ),
              onConfirm: () {
                if (_saveConfig(null, null, null, null,
                        botNameEditingController.text) ==
                    1) {
                  controller.botName.value = botNameEditingController.text;
                }

                Get.back();
              },
              onCancel: () => Get.back(),
            );
          },
        ),
        const Divider(),
        ListTile(
            title: const Text('User Avatar'),
            trailing: chatAvatar(isUser: true),
            onTap: () async {
              // JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'jpg',
                  'jpeg',
                  'png',
                  'webp',
                  'bmp',
                  'wbmp'
                ],
              );

              if (result != null) {
                Uint8List? bytes;
                File file = File(result.files.single.path!);
                debugPrint(file.path);
                bytes = file.readAsBytesSync();
                file = File('${controller.avatarPath}/user_avatar');
                await file.writeAsBytes(bytes);
                controller.userAvatarExists.value = true;
              } else {
                // User canceled the picker
              }
            }),
        const Divider(),
        ListTile(
            title: const Text('Bot Avatar'),
            trailing: chatAvatar(isUser: false),
            onTap: () async {
              // JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'jpg',
                  'jpeg',
                  'png',
                  'webp',
                  'bmp',
                  'wbmp'
                ],
              );

              if (result != null) {
                Uint8List? bytes;
                File file = File(result.files.single.path!);
                debugPrint(file.path);
                bytes = file.readAsBytesSync();
                file = File('${controller.avatarPath}/bot_avatar');
                await file.writeAsBytes(bytes);
                controller.botAvatarExists.value = true;
              } else {
                // User canceled the picker
              }
            }),
        const Divider(),
        ListTile(
          title: const Text('Reset Settings'),
          trailing: ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: 'Reset Settings',
                content: const Text('Are you sure you want to reset settings?'),
                onConfirm: () {
                  final defaultConfig =
                      AppConfig(openAiKey: controller.openAiKey.value);
                  if (_saveConfig(
                          defaultConfig.openAiKey,
                          defaultConfig.showTimeStamp,
                          defaultConfig.showName,
                          defaultConfig.userName,
                          defaultConfig.botName) ==
                      1) {
                    controller.showTimeStamp.value =
                        defaultConfig.showTimeStamp;
                    controller.showName.value = defaultConfig.showName;
                    controller.userName.value = defaultConfig.userName;
                    controller.botName.value = defaultConfig.botName;
                    controller.userAvatarExists.value = false;
                    controller.botAvatarExists.value = false;
                    var file = File('${controller.avatarPath}/bot_avatar');
                    try {
                      file.delete();
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                    file = File('${controller.avatarPath}/user_avatar');
                    try {
                      file.delete();
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  }
                  Get.back();
                },
                onCancel: () => Get.back(),
              );
            },
            child: const Text('Reset'),
          ),
        ),
      ],
    );
  }
}
