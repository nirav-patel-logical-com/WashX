import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/widgets/startwashbutton.dart';

class DryCleanPage extends StatefulWidget {
  @override
  _DryCleanPage createState() => _DryCleanPage();
}

class _DryCleanPage extends State<DryCleanPage>
    with AutomaticKeepAliveClientMixin<DryCleanPage> {
  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Icon(MyFlutterApp.coatrack, size: 175.0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: StartWashButton(onPressed: () {
            _showBottomSheet();
          }),
        ),
      ],
    );
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new DryCleanPage();
        });
  }
}
