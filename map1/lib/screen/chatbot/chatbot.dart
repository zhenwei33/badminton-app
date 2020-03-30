import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Sporty'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView(
                  children: <Widget>[
                    Text('YAYADADA'),
                    Text('YAYADADA'),
                    Text('YAYADADA'),
                    Text('YAYADADA'),
                    Text('YAYADADA'),
                    Text('YAYADADA'),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Start chatting...',
                    ),
                    onSubmitted: (message) => print(message),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    print(_controller.text);
                    FocusScope.of(context).unfocus();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
