import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talk_tn/components/message.dart';
import 'package:talk_tn/services/api/api_service.dart';

class ChatService {
  //get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //go throught each individual user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //get currect user info
    final String currentUserId = _auth.currentUser!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get();
    final DocumentSnapshot receiverDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(receiverID)
        .get();
    final String currentUserName = userDoc["name"];
    final String receiverToken = receiverDoc["fcmToken"];
    final ApiService apiService = ApiService();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
        senderID: currentUserId,
        senderName: currentUserName,
        message: message,
        timestamp: timestamp,
        receiverID: receiverID);
    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverID];
    ids.sort(); //sort the ids(this ensure the chatroomID is the same for any 2 people)
    String chatroomID = ids.join('_');
    //add new message to database
    Future.wait([
      _firestore
          .collection("chat_rooms")
          .doc(chatroomID)
          .collection("message")
          .add(newMessage.toMap()),
      apiService.sendPushNotification(
          title: currentUserName, message: message, fcmToken: receiverToken)
    ]);
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
