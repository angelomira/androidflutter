import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String chatId;

  ChatPage({required this.chatId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  // To send a message
  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    _firestore.collection('chats').doc(widget.chatId).collection('messages').add({
      'sender': 'tech_support',  // Replace with the logged-in tech support ID
      'text': _messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  // To fetch messages for the chat
  Stream<List<DocumentSnapshot>> _getMessages() {
    return _firestore
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Client'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: _getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                var messages = snapshot.data!;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['text']),
                      subtitle: Text(message['sender']),
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
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
