import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import '../ui/app_controller.dart';
import 'entities/app_config.dart';

class ObjectBox extends GetxController {
  /// The Store of this app.
  late final Store store;

  void appConfigDBInit() {
    final appController = Get.find<AppController>();

    if (getConfig() == null) {
      debugPrint("getConfig() == null, new config will be created!");
      _initConfig("API Key is empty!!!");
    }

    final config = getConfig();
    if (config != null) {
      appController.showName.value = config.showName;
      appController.showTimeStamp.value = config.showTimeStamp;
      appController.userName.value = config.userName;
      appController.botName.value = config.botName;
      appController.openAiKey.value = config.openAiKey;
    }
  }

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    appConfigDBInit();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

    final store = Platform.isMacOS
        ? await openStore(macosApplicationGroup: 'FLUTTER.gpt')
        : await openStore(directory: p.join(docsDir.path, "flutter-gpt"));
    return ObjectBox._create(store);
  }

  int saveConfig(AppConfig config) {
    return store.box<AppConfig>().put(config);
  }

  int _initConfig(String apiKey) {
    final config = AppConfig(id: 0, openAiKey: apiKey);
    return store.box<AppConfig>().put(config);
  }

  AppConfig? getConfig() {
    return store.box<AppConfig>().get(1);
  }
}
