import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/MessageHandlers/message_bubble.dart';
import 'package:flutter_chatting_app/screens/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;
class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder:(context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble>messageBubbles = [];
          for (var message in messages!) {
            final messageText = message["text"];
            final messageSender = message['sender'];

            final currentUser = loggedInUser.email;
            if(currentUser== messageSender){


            }
            final messageBubble =MessageBubble(
              sender : messageSender,
              text : messageText,
              isMe: currentUser ==messageSender,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(

            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: messageBubbles,
            ),
          );

        } else {
          return  Container(
            child: Text('No Data Found'),
          );
        }
      },
    );
  }
}