import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<QueryDocumentSnapshot>> _getUsers() async {
    // Get the current user's UID from FirebaseAuth
    var currentUserUid = _auth.currentUser?.uid;

    // Fetch users where uid is stored and has a chatId
    var userCollection = await _firestore
        .collection('users')
        .where('uid', isEqualTo: currentUserUid)
        .get();

    return userCollection.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Support Messenger'),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No clients to chat with.'));
          }

          var users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var chatId = user['chatId'];

              return ListTile(
                title: Text('Chat with ${user.id}'),  // Display UID instead of name
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(chatId: chatId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
