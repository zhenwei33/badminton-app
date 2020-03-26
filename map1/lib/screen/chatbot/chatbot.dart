import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Sporty'),
      ),
      body: Column(
        children: <Widget>[
          ListView(
            children: <Widget>[Text('YAYADADA')],
          ),
          Row(
            children: <Widget>[
              TextField(
                textCapitalization: TextCapitalization.sentences,
                decoration:
                    InputDecoration.collapsed(hintText: 'Start chatting...'),
              )
            ],
          )
        ],
      ),
    );
  }
}
