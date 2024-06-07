import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController controller = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String?;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var doc in snapshot.data!.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            if (data['body'] != null && data['createdAt'] != null) {
              messagesList.add(Message.fromJson(data));
            }
          }
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  Text(
                    "Cloud Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      var message = messagesList[index];
                      return message.id == email
                          ? ChatBuble(message: message)
                          : ChatBubleForFriend(message: message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: kPrimaryColor),
                        onPressed: () {
                          // Check if the input is not empty
                          if (controller.text.isNotEmpty) {
                            messages.add({
                              kBody: controller.text,
                              kCreatedAt: DateTime.now(),
                              'id': email ?? 'unknown',
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
