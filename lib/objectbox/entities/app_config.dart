import 'package:objectbox/objectbox.dart';

@Entity()
class AppConfig {
  @Id()
  int id = 0;
  String openAiKey;
  bool showTimeStamp = true;
  bool showName = true;
  String userName = "Shrimp";
  String botName = "Chicken";

  AppConfig({this.id = 0, required this.openAiKey});
}
