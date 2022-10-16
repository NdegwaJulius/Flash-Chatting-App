import 'package:flutter/material.dart';
import 'package:flutter_chatting_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  static String id ='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String MessageText;

  @override
  void initState() {

    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e) {
      print(e);
    }

  }
  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //
  //   for (var message in messages.docs) { // <-- BEFORE
  //     print(message.data());
  //   }
  //
  //   for (var message in messages.docs) { // <-- NOW
  //     print(message.data());
  //   }
  // }
  void messageStream() async{
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for(var message in snapshot.docs){
        print(message.data);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                //Implement logout functionality
               // _auth.signOut();
                //getMessages();
                messageStream();
               // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                          MessageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                          {
                            'text':MessageText,
                            'sender':loggedInUser.email
                          }
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder:(context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs;
          List<MessageBubble>messageBubbles = [];
          for (var message in messages!) {
            final messageText = message["text"];
            final messageSender = message['sender'];
            final messageBubble =MessageBubble(
                sender : messageSender,
                text : messageText
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(

            child: ListView(
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

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.sender,
    required  this.text,
  });
  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children:<Widget> [
          Text(
              sender,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54
              ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(text,
                style: TextStyle(
                    //color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

