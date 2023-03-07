import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gpt/routes.dart';
import 'package:flutter_gpt/ui/app_controller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'objectbox/objectbox.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  final userAvatarExists = await File('${directory.path}/user_avatar').exists();
  final botAvatarExists = await File('${directory.path}/bot_avatar').exists();
  Get.put(
      AppController(iAvatarPath: directory.path, isUserAvatarExists: userAvatarExists,isBotAvatarExists: botAvatarExists));
  objectbox = await ObjectBox.create();
  Get.put(objectbox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/appPage',
      getPages: routes,
    );
  }
}
