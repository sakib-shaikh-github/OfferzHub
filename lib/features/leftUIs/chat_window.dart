// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String otherName;
  const ChatScreen({
    Key? key,
    required this.otherName,
  }) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Row(
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration: InputDecoration.collapsed(hintText: "Send a message"),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () => _handleSubmitted(_textController.text),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          title: Text("Chat with ${widget.otherName}"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _buildMessage(_messages[index]),
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 25,
              child: Text("User"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("User", style: Theme.of(context).textTheme.titleMedium),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
