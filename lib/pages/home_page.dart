import 'package:flutter/material.dart';
import 'package:talk_tn/components/my_drawer.dart';
import 'package:talk_tn/components/user_tile.dart';
import 'package:talk_tn/pages/chat_page.dart';
import 'package:talk_tn/services/auth/auth_service.dart';
import 'package:talk_tn/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//chat&auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //get current user
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged i users
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          }
          //return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }
  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: UserTile(
          text: userData["name"],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiverEmail: userData["name"],
                          receiverID: userData["uid"],
                        )));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
