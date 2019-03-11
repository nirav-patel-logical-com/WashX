import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wash_x/models/user.dart';
import 'package:wash_x/widgets/helperWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  // static FacebookLogin facebookLogin = new FacebookLogin();

  static Future<bool> checkUserByEmail(String email) async {
    final QuerySnapshot resultQuery = await Firestore.instance
        .collection('users')
        .where('Email', isEqualTo: email.toLowerCase())
        .getDocuments();
    return resultQuery.documents.length == 0 ? false : true;
  }

  ///check phone number into db and return email if exist else empty value.
  static Future<String> checkUserByPhone(String phone) async {
    final QuerySnapshot resultQuery = await Firestore.instance
        .collection('users')
        .where('Phone Number', isEqualTo: phone)
        .getDocuments();
    return resultQuery.documents.length > 0
        ? resultQuery.documents[0].data["Email"]
        : '';
  }

  ///check phone number into db and return email if exist else empty value.
  static Future<String> checkUserByUsername(String username) async {
    final QuerySnapshot resultQuery = await Firestore.instance
        .collection('users')
        .where('User Name', isEqualTo: username)
        .getDocuments();
    return resultQuery.documents.length > 0
        ? resultQuery.documents[0].data["Email"]
        : '';
  }

  static Future<String> resetPasswordFirebase(String email) async {
    var error;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .catchError((e) {
      var exception = e as PlatformException;
      error = exception.message;
    });
    return error;
  }

  static Future<String> loginUserByEmailAndPassword(
      String email, String password) async {
    var error;
    var emailUser = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.toLowerCase(), password: password)
        .catchError((e) {
      error = "Invalid Password";
    });
    if (emailUser != null) {}
    return error;
  }

  static Future<CustomFirebaseUser> loginUserByFacebook(String token) async {
    String error = '';
    FirebaseUser firebaseUser = await FirebaseAuth.instance
        .signInWithFacebook(accessToken: token)
        .catchError((e) {
      var tt = e as PlatformException;
    });
    return new CustomFirebaseUser(firebaseUser, error);
  }

  static Future requestMethod({firstname, lastname}) async {
   /* var url =
        "https://us-central1-pages.wash-x1.cloudfunctions.net/getUserName";*/
    var url = "https://us-central1-wash-x1.cloudfunctions.net/getUserName";
    var body = json.encode({"firstname": firstname, "lastname": lastname});
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(url, body: body, headers: headers);
    final responseJson = response.body;
    return responseJson;
  }

  static Future<String> signupUser(User user) async {
    String error;
//  var rng = new Random();
//     var randomlist = new List.generate(10, (_) => rng.nextInt(100));
//     var random = '12';
//     for (var i = 0; i < 5; i++) {
//       random = random + randomlist[i].toString();
//     }

    var userName =
        await requestMethod(firstname: user.firstName, lastname: user.lastName);
    await Firestore.instance.collection('users').document(user.email).setData({
      'First Name': user.firstName,
      'Last Name': user.lastName,
      'Email': user.email.toLowerCase(),
      //password for dev purpose only
      //'Password': user.password,
      'Phone Number': user.phoneNumber,
      'User Name': userName,
      'Profile Picture': ""
    }).catchError((e) {
      var platformException = e as PlatformException;
      error = platformException.message;
      print(platformException.message);
    });

    var emailUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .catchError((e) {
      // Navigator.of(context).pop();
      var platformException = e as PlatformException;
      error = platformException.message;
      print(platformException.message);
    });

    if (emailUser != null) {
      error = '';
    }
    return error;
  }

  static Future<CustomFirebaseUser> loginUserByGoogle(
      GoogleSignInAccount googleUser) async {
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    String error = '';
    FirebaseUser firebaseUser = await FirebaseAuth.instance
        .signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    )
        .catchError((e) {
      var exception = e as PlatformException;
      error = exception.message;
    });
    return new CustomFirebaseUser(firebaseUser, error);
  }

  // get user by email id
  static Future<DocumentSnapshot> getUserByEmail(String strEmail) async {
    final QuerySnapshot resultQuery = await Firestore.instance
        .collection('users')
        .where('Email', isEqualTo: strEmail)
        .getDocuments();
    return resultQuery.documents.length > 0
        ? resultQuery.documents[0]
        : null;
  }
}

class CustomFirebaseUser {
  CustomFirebaseUser(this.user, this.error);
  FirebaseUser user;
  String error;
}
