import 'package:flutter/material.dart';

 class HelperWidgets {
 static loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
       return new Center(
        heightFactor: 2.0,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
          ],
        ),
      );
      } 
    );
  }

 static alertDialog(BuildContext context, title, message, actionReturn) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(message),
            actions: <Widget>[
              new FlatButton(
                  child: new Text(actionReturn),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
