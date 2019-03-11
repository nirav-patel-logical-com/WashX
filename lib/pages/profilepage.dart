import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return new Center(child: new Text("Profile page"));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
