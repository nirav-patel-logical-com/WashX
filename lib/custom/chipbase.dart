import 'package:flutter/material.dart';

class WashChip extends StatelessWidget {
  const WashChip({
    this.bottonSheet,
    this.label,
    this.avatar,
//    this.onPressed
  });

  final Widget bottonSheet;
  final Widget avatar;
  final Widget label;
//  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(right: 5.0),
      child: new Card(elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(const Radius.circular(16.0))),
        child: new ActionChip(
          onPressed: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return bottonSheet;
              }
            );
          },
          label: label,
          padding: new EdgeInsets.all(5.0),
          avatar: avatar)
      )
    );
  }

  _showBottomSheet(Widget content, BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return content;
        }
    );
  }
}

