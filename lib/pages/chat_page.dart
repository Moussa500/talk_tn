import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_tn/components/chat_bubble.dart';
import 'package:talk_tn/components/my_textfield.dart';
import 'package:talk_tn/services/auth/auth_service.dart';
import 'package:talk_tn/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  //text controller
  final TextEditingController _messageController = TextEditingController();
  //chat & auth Services
  final ChatService _chatService = ChatService();
  final _authService = AuthService();
  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send the message
      await _chatService.sendMessage(receiverID, _messageController.text);
      //clear text controlelr
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display all the messages
          Expanded(child: _buildMessageList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //return list view
          return 
             ListView(
              children: snapshot.data!.docs
                  .map((doc) => _buildMessageItem(doc))
                  .toList(),
      
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser=data['senderID']==FirebaseAuth.instance.currentUser!.uid?true:false;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return
              Container(
                alignment: alignment,
                child: Row(
                  mainAxisAlignment: isCurrentUser? MainAxisAlignment.start:MainAxisAlignment.end,
                  children: [
                    ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
                  ],
                ));
  }


  //build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        //textfield should take up most of the space
        Expanded(
            child: MyTextField(
          controller: _messageController,
          obscureText: false,
          hintText: "Type a message",
        )),
        //send button
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward))
      ],
    );
  }
}
