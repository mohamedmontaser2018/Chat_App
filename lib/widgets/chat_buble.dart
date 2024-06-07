import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //color: kBackground, // Set your desired background color here
        child: Column(
          children: [
            Container(
              //height: 65,
              //alignment: Alignment.centerLeft,
              //width: 150,
              padding: EdgeInsets.only(
                left: 16,
                top: 32,
                bottom: 32,
                right: 32,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
                color: kPrimaryColor,
              ),
              child: Text(
                message.body,
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Add more widgets here if needed
          ],
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //color: kBackground, // Set your desired background color here
        child: Column(
          children: [
            Container(
              //height: 65,
              //alignment: Alignment.centerLeft,
              //width: 150,
              padding: EdgeInsets.only(
                left: 16,
                top: 32,
                bottom: 32,
                right: 32,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                color: Colors.green,
              ),
              child: Text(
                message.body,
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Add more widgets here if needed
          ],
        ),
      ),
    );
  }
}
