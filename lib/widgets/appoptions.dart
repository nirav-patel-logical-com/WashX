import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/models/model.dart';

class AppOptions extends StatelessWidget {

  RemoteConfig remoteConfig;
  //WashRemote washRemote = WashRemote();

  void _fetch() async {
    try{
      await remoteConfig.fetch(expiration: const Duration(seconds: 5));
      await remoteConfig.activateFetched();
    } on FetchThrottledException catch (exception) {
      print('Exception:$exception');
    } catch (exception) {
      print(
        'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  void _remote(WashModel model) async{
    remoteConfig = await setupRemoteConfig();
    String app_options = remoteConfig.getString('app_option_menu');
    print('---------$app_options');
    (json.decode(app_options) as List).forEach((f){
      model.addItem(WashRemoteItem.fromMap(f));
    });
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(
      builder: (context, child, model) {
        _remote(model);
        List<WashRemoteItem> list = model.configs.where((i) => i.is_active).toList();
        return new Container(
        margin: new EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                child: new Icon(Icons.drag_handle)
              ),
              new Text('APP OPTIONS',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.blueAccent
                )
              ),
              new Expanded(
                child: ListView.builder(
                  cacheExtent: 0.0,
                  itemCount: list.length,
                  itemBuilder: (context, int index) {
                    print('index:$index');
                    print('item:${list[index].menu_title}');
                      return new ListTile(
                        leading: new Image.network(list[index].menu_image),
                        title: new Text(list[index].menu_title)
                      );
                  }
                )
              )
            ]
        )
      );
    });
  }
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  return remoteConfig;
}
