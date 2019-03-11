// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';


// class AppKeyword {
//   static String ITEM_USER_OPTION_MENU = 'user_option_menu',
//       ITEM_APP_OPTION_MENU = 'app_option_menu',


//       KEY_MENU_TITLE = "menu_title",
//       KEY_MENU_IMAGE = "menu_image",
//       KEY_IS_ACTIVE = "is_active",
//       KEY_MENU_ID = "menu_id",


//       ic_user = "images/ic_user.png";
// }

// class Global {
//   static void showCallDialogM(BuildContext contextM, String strMessage) {
//     // return object of type Dialog
//     var alert = new AlertDialog(
//       title: Text(
//         "You are click on !!!",
//         style: TextStyle(
//             color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
//       ),
//       content: Text(
//         strMessage,
//         style: TextStyle(color: Colors.black87, fontSize: 14.0),
//       ),
//       actions: <Widget>[
//         new FlatButton(
//           child: new Text(
//             'Ok',
//             style: TextStyle(color: Colors.black87, fontSize: 14.0),
//           ),
//           onPressed: () {
//             Navigator.of(contextM, rootNavigator: true).pop('dialog');
//           },
//         ),
//       ],
//     );
//     showDialog(context: contextM, child: alert);
//   }
// }
class GlobalVariables{
//Global variables for navigating and repositioning the assistant Icon --start
static double assistantMagrginWardrobe=0.0;
static double assistantMagrginAccount=05.0;
static double assistantMagrginFreeWash=05.0;
static double assistantMagrginDefault=55.0;
//Global variables for navigating and repositioning the assistant Icon --end
}