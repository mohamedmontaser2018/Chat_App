import 'package:chat_app/constants.dart';

class Message {
  final String body;
  final String id;
  Message(this.body, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kBody], jsonData['id']);
  }
}
