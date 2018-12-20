import 'package:flutter/material.dart';
import 'chat_message.dart';

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildText(context),
        )
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: <Widget>[
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _onSubmit,
          decoration: InputDecoration.collapsed(hintText: "Type a message"),
        )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _onSubmit(_textController.text),
          ),
        )
      ]),
    );
  }

  void _onSubmit(String text) {
    _textController.clear();
    ChatMessage newMessage = ChatMessage(text, "Sid");
    setState(() {
      _messages.insert(0, newMessage);
    });
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}
