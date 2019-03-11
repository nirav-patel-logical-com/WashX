// import 'dart:async';
// import 'dart:convert';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';
// import 'package:wash_x/global.dart';

// void main() {
//   runApp(new MaterialApp(
//       title: 'Wash X',
//       home: new FutureBuilder<RemoteConfig>(
//         future: setupRemoteConfig(),
//         builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
//           return snapshot.hasData
//               ? new WelcomeWidget(remoteConfig: snapshot.data)
//               : new Container();
//         },
//       )));
// }

// class WelcomeWidget extends AnimatedWidget {
//   WelcomeWidget({this.remoteConfig}) : super(listenable: remoteConfig);

//   final RemoteConfig remoteConfig;
//   int selectedMenuId = -1;

//   @override
//   Widget build(BuildContext context) {
//     // list of Widgets
//     List<Widget> drawerAppOptions = new List();

//     List<Widget> drawerUserOptions = new List();

//     //Main Header
//     Widget mainHeader = Container(
//       margin: EdgeInsets.only(top: 5.0, bottom: 18.0),
//       child: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(bottom: 15.0),
//             decoration: new BoxDecoration(
//               color: Colors.black12,
//               borderRadius: new BorderRadius.all(new Radius.circular(11.0)),
//               border: new Border.all(color: Colors.black12, width: 0.0),
//             ),
//             height: 6.0,
//             width: 30.0,
//           ),
//           Stack(
//               children: <Widget>[
//                 Image.asset(
//                   AppKeyword.ic_user,
//                   height: 36.0,
//                   alignment: Alignment.centerLeft,
//                   width: 36.0,
//                 ),
//                 Container(
//                     alignment: Alignment.centerLeft,
//                     margin: EdgeInsets.only(left: 38.0),
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         new Text(
//                           'Mendy Marcus',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         new Text(
//                           'mendymarcus@gmail.com',
//                           style: TextStyle(color: Colors.black87, fontSize: 12.0),
//                         ),
//                       ],
//                     )),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   margin: EdgeInsets.only(left: 36.0),
//                   height: 36.0,
//                   child: new Text(
//                     'LOGOUT',
//                     style: TextStyle(color: Colors.black87, fontSize: 14.0),
//                   ),
//                 )
//               ]

//           ),
//         ],
//       ),
//     );

//     drawerUserOptions.add(mainHeader);

//     drawerAppOptions.add(Container(
//       margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
//       decoration: new BoxDecoration(
//         color: Colors.black12,
//         borderRadius: new BorderRadius.all(new Radius.circular(11.0)),
//         border: new Border.all(color: Colors.black12, width: 0.0),
//       ),
//       height: 6.0,
//       width: 30.0,
//     ));

//     //Option Menu
//     String strUserOptionMenu =
//         remoteConfig.getString(AppKeyword.ITEM_USER_OPTION_MENU);

//     String strAppOptionMenu =
//         remoteConfig.getString(AppKeyword.ITEM_APP_OPTION_MENU);

//     if (strUserOptionMenu != null && strUserOptionMenu.isNotEmpty) {
//       var data = json.decode(strUserOptionMenu);

//       for (var userMenuData in data) {
//         String strMenuTitle =
//             userMenuData[AppKeyword.KEY_MENU_TITLE].toString();

//         String strMenuImage =
//             userMenuData[AppKeyword.KEY_MENU_IMAGE].toString();

//         bool strMenuIsActive = userMenuData[AppKeyword.KEY_IS_ACTIVE];

//         int strMenuId = userMenuData[AppKeyword.KEY_MENU_ID];

//         Widget listItem = InkResponse(
// //          onTap: () => _onSelectItem(i),
//             onTap: () {
//               Global.showCallDialogM(context, strMenuTitle.trim());
//             },
//             highlightShape: BoxShape.rectangle,
//             radius: 0.0,
//             child: Container(
//               height: 38.0,

//               padding: EdgeInsets.only(
//                 left: 12.0,
//                 top: 7.0,
//                 bottom: 7.0,
//                 right: 7.0,
//               ),
// //            color: i == _selectedDrawerIndex ? AppColors.colorSemiTrans : null,
//               child: Row(
//                 children: <Widget>[
//                   Image.network(
//                     strMenuImage,
//                     color: Colors.black87,
//                     height: 20.0,
//                     width: 20.0,
//                   ),
//                   Container(
//                       padding: EdgeInsets.only(left: 15.0),
//                       child: new Text(
//                         strMenuTitle,
//                         style: TextStyle(color: Colors.black87, fontSize: 14.0),
//                       ))
//                 ],
//               ),
//             ));

//         if (strMenuIsActive) {
//           drawerUserOptions.add(listItem);
//         }
//       }
//     }

//     if (strAppOptionMenu != null && strAppOptionMenu.isNotEmpty) {
//       var data = json.decode(strAppOptionMenu);

//       for (var userMenuData in data) {
//         String strMenuTitle =
//             userMenuData[AppKeyword.KEY_MENU_TITLE].toString();

//         String strMenuImage =
//             userMenuData[AppKeyword.KEY_MENU_IMAGE].toString();

//         bool strMenuIsActive = userMenuData[AppKeyword.KEY_IS_ACTIVE];

//         int strMenuId = userMenuData[AppKeyword.KEY_MENU_ID];

//         Widget listItem = InkResponse(
// //          onTap: () => _onSelectItem(i),
//             onTap: () {
//               Global.showCallDialogM(context, strMenuTitle.trim());
//             },
//             highlightShape: BoxShape.rectangle,
//             radius: 0.0,
//             child: Container(
//               height: 45.0,

//               padding: EdgeInsets.only(
//                 left: 12.0,
//                 top: 7.0,
//                 bottom: 7.0,
//                 right: 7.0,
//               ),
// //            color: i == _selectedDrawerIndex ? AppColors.colorSemiTrans : null,
//               child: Row(
//                 children: <Widget>[
//                   Image.network(
//                     strMenuImage,
//                     color: Colors.black87,
//                     height: 20.0,
//                     width: 20.0,
//                   ),
//                   Container(
//                       padding: EdgeInsets.only(left: 15.0),
//                       child: new Text(
//                         strMenuTitle,
//                         style: TextStyle(color: Colors.black87, fontSize: 14.0),
//                       ))
//                 ],
//               ),
//             ));

//         if (strMenuIsActive) {
//           drawerAppOptions.add(listItem);
//         }
//       }
//     }

//     return new Scaffold(
//       appBar: new AppBar(
//         title: const Text('Wash X'),
//       ),
//       body:  Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0 , 100.0),
//             child: new Text('Wash X',
//               textAlign: TextAlign.center,
//               textScaleFactor: 5.0,
//               style: TextStyle(color: Colors.black87, fontSize: 14.0),
//               ),
//             ),
// //            new Text('Wash X',
// //              textAlign: TextAlign.center,
// //              textScaleFactor: 5.0,
// //              style: TextStyle(color: Colors.black87, fontSize: 14.0),),
// //            Container(height: 120.0,),
//             new RaisedButton(
//               child: const Text('USER OPTIONS'),
//               onPressed: () async {
//                 try {
//                   // Using default duration to force fetching from remote server.
//                   await remoteConfig.fetch(
//                       expiration: const Duration(seconds: 0));
//                   await remoteConfig.activateFetched();
//                 } on FetchThrottledException catch (exception) {
//                   // Fetch throttled.
//                   print(exception);
//                 } catch (exception) {
//                   print(
//                       'Unable to fetch remote config. Cached or default values will be '
//                       'used');
//                 }

//                 showModalBottomSheet<void>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return new Container(
//                           child: new Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 32.0, right: 15.0),
//                             child: new Column(children: drawerUserOptions),
//                           ),
// //                          decoration: new BoxDecoration(
// //                            borderRadius: new BorderRadius.only(
// //                                topRight: new Radius.circular(11.0),
// //                                topLeft: new Radius.circular(11.0)),
// //                            border: new Border.all(
// //                              color: Colors.black12,
// //                              width: 1.8,
// //                            ),
// //                          ),
//                       );
//                     });
//               },
//             ),
//            Container(height: 30.0,),
//             new RaisedButton(
//               child: const Text('APP OPTIONS'),
//               onPressed: () async {
//                 try {
//                   // Using default duration to force fetching from remote server.
//                   await remoteConfig.fetch(
//                       expiration: const Duration(seconds: 0));
//                   await remoteConfig.activateFetched();
//                 } on FetchThrottledException catch (exception) {
//                   // Fetch throttled.
//                   print(exception);
//                 } catch (exception) {
//                   print(
//                       'Unable to fetch remote config. Cached or default values will be '
//                       'used');
//                 }

//                 showModalBottomSheet<void>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return new Container(
//                           child: new Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 15.0, right: 15.0),
//                             child: new Column(children: drawerAppOptions),
//                           ),
// //                          decoration: new BoxDecoration(
// //                            borderRadius: new BorderRadius.only(
// //                                topRight: new Radius.circular(11.0),
// //                                topLeft: new Radius.circular(11.0)),
// //                            border: new Border.all(
// //                              color: Colors.black12,
// //                              width: 1.8,
// //                            ),
// //                          ),
//                       );
//                     });
//               },
//             ),
//           ],
//         ),
//     );
//   }
// }

// refresh(remoteConfig) async {
//   try {
//     // Using default duration to force fetching from remote server.
//     await remoteConfig.fetch(expiration: const Duration(seconds: 0));
//     await remoteConfig.activateFetched();
//   } on FetchThrottledException catch (exception) {
//     // Fetch throttled.
//     print(exception);
//   } catch (exception) {
//     print('Unable to fetch remote config. Cached or default values will be '
//         'used');
//   }
// }

// Future<RemoteConfig> setupRemoteConfig() async {
//   final RemoteConfig remoteConfig = await RemoteConfig.instance;
//   // Enable developer mode to relax fetch throttling
//   remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
//   remoteConfig.setDefaults(<String, dynamic>{
//     'welcome': 'default welcome',
//     'hello': 'default hello',
//   });
//   return remoteConfig;
// }
