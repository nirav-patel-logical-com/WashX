import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/widgets/dialog_flow.dart';
import 'package:wash_x/widgets/setupScreenWidgets.dart';
import 'package:simple_permissions/simple_permissions.dart';

class AssistantPage extends StatefulWidget {
  final _AssistantPageState _setupPageState = new _AssistantPageState();
  void showHideMsgField() {
    _setupPageState.showHideMsgField();
  }

  void handleSubmittedVoice(String command) {
    _setupPageState.handleSubmitted(command);
  }

  @override
  _AssistantPageState createState() => _setupPageState;
}

class _AssistantPageState extends State<AssistantPage>
    with TickerProviderStateMixin {
  FocusNode _focusnode = new FocusNode();
  List<Widget> _itemCards = <Widget>[];
  TextEditingController _textController = new TextEditingController();
  AnimationController firstController;
  FlutterTts _textToSpeech = new FlutterTts();

  bool _msgFieldVisible = true;
  String transcription = '';
  Permission permission;

  @override
  void initState() {
    super.initState();

    firstController = new AnimationController(
      duration: new Duration(seconds: 1),
      vsync: this,
    );
    Future.delayed(Duration(milliseconds: 300), _startLoading());
  }

  void showHideMsgField() {
    _msgFieldVisible = !_msgFieldVisible;
    setState(() {});
  }

  TtsState ttsState;
  Future _speak(String text) async {
    var result = await _textToSpeech.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.PLAYING);
  }

  @override
  void dispose() {
    super.dispose();
    firstController.dispose();
  }

  _startLoading() {
    debugPrint("helloi");
    _itemCards.insert(0, _buildTopView());
    firstController.forward();
    _itemCards.insert(
        0,
        SetupScreenWidgets.messageBox(
            "What can I do for you?", firstController));
  }

  void handleSubmitted(String text) {
    //  _speechToText.stop();
    if (text.isEmpty || text == null) {
      return;
    }
    _textController.clear();
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(
        0, SetupScreenWidgets.messageBoxReverse(text, controller));

    setState(() {});
    response(text);
  }

  void response(query) async {
    _textController.clear();
    Dialogflow dialogflow =
        Dialogflow(token: "283266f2996b498bb665454d0ad309d8");
    AIResponse response = await dialogflow.sendQuery(query);
    var responce = response.getMessageResponse();
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(0, SetupScreenWidgets.messageBox(responce, controller));
    setState(() {
      _speak(responce);
    });
  }

  AnimationController _buildNewAnimationController() {
    var controller = new AnimationController(
      duration: new Duration(milliseconds: 500),
      vsync: this,
    );
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusnode);
          },
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                // flex: 14,
                child: new Stack(
                  children: <Widget>[
                    _buildMainList(),
                    new Positioned(
                      bottom: 0.0,
                      child: _buildAssistantRow(),
                    )
                  ],
                ),
              ),
              new Container(height: _msgFieldVisible ? 60.0 : 0.0),
            ],
          ),
        ));
  }

  _buildAssistantRow() {
    return new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: _msgFieldVisible ? 10.0 : 0.0),
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: _msgFieldVisible ? 60.0 : 0.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: !_msgFieldVisible
            ? new Container()
            : new TextField(
                controller: _textController,
                onSubmitted: (String text) => handleSubmitted(text),
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ));
  }

  _buildMainList() {
    return new Container(
        padding: EdgeInsets.only(bottom: 10.0),
        color: Colors.white,
        child: new ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => _itemCards[index],
          itemCount: _itemCards.length,
          padding: EdgeInsets.only(bottom: 60.0, left: 20.0, right: 20.0),
          reverse: true,
        ));
  }

  _buildTopView() {
    return new Column(
      children: <Widget>[
        new Container(
          width: 550.0,
          margin: EdgeInsets.only(left: 0.0, top: 25.0),
          child: new Text(
            "Hey Again",
            textAlign: TextAlign.left,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
        ),
        new Container(
          width: 550.0,
          height: 60.0,
          margin: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 15.0),
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/assistant.png"),
                backgroundColor: Colors.white,
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: new Text(
                  "Joan Wike",
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
