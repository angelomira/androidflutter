import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/service_chat_firebase.dart';

class ChatPage extends StatelessWidget {
  final String chatId;
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  ChatPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Tech support")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessages(chatId),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                List<DocumentSnapshot> docs = snapshot.data.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data();
                    return ListTile(
                      title: Text((data as Map<String, dynamic>)['text']),
                      subtitle: Text((data)['sender']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: messageController),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (messageController.text.isNotEmpty) {
                      await _chatService.sendMessage(chatId, messageController.text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
