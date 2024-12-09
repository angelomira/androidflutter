import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getOrCreateChat() async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
    if (userDoc.exists && userDoc['chatId'] != null) {
      return userDoc['chatId'];
    }

    DocumentReference chatRef = await _firestore.collection('chats').add({
      'userId': user.uid,
    });

    await _firestore.collection('users').doc(user.uid).set({
      'chatId': chatRef.id,
    }, SetOptions(merge: true));

    return chatRef.id;
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String chatId, String message) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'sender': user.uid ?? "Anonymous",
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}