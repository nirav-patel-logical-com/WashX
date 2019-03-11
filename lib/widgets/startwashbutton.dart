import 'package:flutter/material.dart';

class StartWashButton extends StatelessWidget {
  final VoidCallback onPressed;

  StartWashButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: StadiumBorder(),
      color: Colors.white,
      elevation: 3.0,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        'START A WASH',
        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
