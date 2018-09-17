import 'package:flutter/material.dart';

import './message.dart';

class my_app extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatScreenState();
  }
}

class ChatScreenState extends State<my_app> with TickerProviderStateMixin {

  final TextEditingController _textController =
  new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage message = new ChatMessage(text: text, animationController:
    new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 700)));
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme
          .of(context)
          .accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Freindly Chat"),
        ),
        body: new Column(
          children: <Widget>[
            new Flexible(
                child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (_, int index) => _messages[index]
                )
            ),
            new Divider(height: 1.0,),

            new Container(
                decoration: new BoxDecoration(
                    color: Theme
                        .of(context)
                        .cardColor),
                child: _buildTextComposer()),
          ],
        )
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

}
