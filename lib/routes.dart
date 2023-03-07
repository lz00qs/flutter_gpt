import 'package:flutter_gpt/ui/app_page.dart';
import 'package:flutter_gpt/ui/display_chat_page.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: "/appPage", page: () => AppPage()),
  GetPage(name: "/displayChatPage", page: () => const DisplayChatPage()),
];
