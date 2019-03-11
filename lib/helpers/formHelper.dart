import 'dart:async';

import 'package:wash_x/enum.dart';
import 'package:wash_x/models/inputFieldInfo.dart';
import 'package:wash_x/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormHelper {
  static const platform = const MethodChannel('samples.flutter.io/toast');
  static const String regexEmail = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String regexNumber = r"^[-+]?\d*$";
   static const String regexPhone = r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$";

 static Future<Null> getToast(String message) async {
    try {
      await platform.invokeMethod('getToast',
          <String, dynamic>{"msg": message});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  static List<InputFieldTypes> _allFields = [
    InputFieldTypes.USERNAME_EMAIL_PHONE,
    InputFieldTypes.PASSWORD,
    InputFieldTypes.FIRST_NAME,
    InputFieldTypes.LAST_NAME,
    InputFieldTypes.EMAIL,
    InputFieldTypes.PHONE,
    InputFieldTypes.USERNAME
  ];
  static List<String> _inputValues = ['', '', '', '', '', '', '', ''];

  static List<InputFieldTypes> _inputFields = [];

  static void init(List<InputFieldTypes> skipFields) {
    clearValues();
    if (skipFields == null) skipFields = [];
    skipFields.add(InputFieldTypes.USERNAME);
    _inputFields.length = 0;
    for (var i = 0; i < _allFields.length; i++) {
      if (skipFields != null && skipFields.contains(_allFields[i])) {
        continue;
      }
      _inputFields.add(_allFields[i]);
    }
  }

  static void clearValues() {
    _inputValues = ['', '', '', '', '', '', '', ''];
  }

  static String getInputFieldValue(InputFieldTypes type) {
    var index = _allFields.indexOf(type);
    return _inputValues[index];
  }

  static void setInputFieldValue(InputFieldTypes type, String value) {
    var index = _allFields.indexOf(type);
    _inputValues[index] = value;
  }

  static InputFieldInfo getNextInputField(int index) {
    InputFieldTypes type = _inputFields[index];
    return getNextInputFieldByType(type);
  }

  static void removeInputFieldValue(InputFieldTypes type) {
    _inputFields.remove(type);
  }

  static int getInputFieldsCount() {
    return _inputFields.length;
  }

  static User getCurrentUser() {
    User u = new User();
    for (int i = 0; i < _allFields.length; i++) {
      var type = _allFields[i];
      var value = _inputValues[i];

      //type = getTypeOfInput(type, value);

      if (type == InputFieldTypes.USERNAME)
        u.username = value;
      else if (type == InputFieldTypes.EMAIL) {
        u.email = value;
      } else if (type == InputFieldTypes.FIRST_NAME)
        u.firstName = value;
      else if (type == InputFieldTypes.LAST_NAME)
        u.lastName = value;
      else if (type == InputFieldTypes.PHONE)
        u.phoneNumber = value;
      else if (type == InputFieldTypes.PASSWORD) u.password = value;
    }
    return u;
  }

  static InputFieldInfo getNextInputFieldByType(InputFieldTypes type) {
    var value = getInputFieldValue(type);
    InputFieldInfo result;
    switch (type) {
      case InputFieldTypes.USERNAME_EMAIL_PHONE:
        result = new InputFieldInfo(
            type: type, value: value, labelText: 'USERNAME EMAIL PHONE');
        break;
      case InputFieldTypes.PASSWORD:
        result = new InputFieldInfo(
            type: type, labelText: 'PASSWORD', value: value, isObscure: true);
        break;
      case InputFieldTypes.FIRST_NAME:
        result = new InputFieldInfo(
            type: type, value: value, labelText: 'FIRST NAME');
        break;
      case InputFieldTypes.LAST_NAME:
        result = new InputFieldInfo(
            type: type, value: value, labelText: 'LAST NAME');
        break;
      case InputFieldTypes.PHONE:
        result = new InputFieldInfo(
            type: type,
            value: value,
            labelText: 'PHONE',
            inputKeyboardType: TextInputType.phone);
        break;
      case InputFieldTypes.EMAIL:
        result = new InputFieldInfo(
            type: type,
            value: value,
            labelText: 'EMAIL',
            inputKeyboardType: TextInputType.emailAddress);
        break;
      default:
        result = null;
        break;
    }
    return result;
  }

  static InputFieldTypes getTypeOfInput(InputFieldTypes type, String value) {
    if (type != InputFieldTypes.USERNAME_EMAIL_PHONE) {
      return type;
    }
    return value == null || value.isEmpty
        ? InputFieldTypes.USERNAME_EMAIL_PHONE
        : value.contains('@')
            ? InputFieldTypes.EMAIL
            : (value.length > 2 && new RegExp(regexNumber).hasMatch(value))
                ? InputFieldTypes.PHONE
                : InputFieldTypes.USERNAME;
  }

  static String validateInputField(InputFieldTypes type, String value) {
    String error = '';
    if (value != null && value.length > 100) {
      error = 'Invalid input.';
      return error;
    }
    type = getTypeOfInput(type, value);
    switch (type) {
      case InputFieldTypes.USERNAME_EMAIL_PHONE:
        if (value == null || value.isEmpty) {
          error = 'Please enter a valid username or email or phone number.';
        }
        break;
      case InputFieldTypes.USERNAME:
        if (value == null || value.isEmpty)
          error = 'Username field is required';
        else if (value.length < 3)
          error = 'Invalid username.';
        else if (value.length > 50)
          error = 'Username field should not be more than 50 characters.';
        break;
      case InputFieldTypes.PASSWORD:
         if (value.length < 6)
          error = 'Password must be of atleast 6 characters';
        break;
      case InputFieldTypes.FIRST_NAME:
        if (value == null || value.isEmpty)
          error = 'First Name field is required';
        else if (value.length > 20)
          error = 'First name field should not be more than 20 characters.';
        break;
      case InputFieldTypes.LAST_NAME:
        if (value != null && value.length > 20)
          error = 'Last name field should not be more than 20 characters.';
        break;
      case InputFieldTypes.PHONE:
      if(value.isEmpty){
        error='';
      }
      else
        if (value != null &&
            (value.length < 10 || !RegExp(regexPhone).hasMatch(value)))
          error = 'Invalid phone number format.';
        break;
      case InputFieldTypes.EMAIL:
        if (value == null || value.isEmpty)
          error = 'Email field is required';
        else if (!RegExp(regexEmail).hasMatch(value))
          error = 'Invalid email address format.';
        break;
      default:
        error = 'something wrong!';
        break;
    }
    return error;
  }
}
