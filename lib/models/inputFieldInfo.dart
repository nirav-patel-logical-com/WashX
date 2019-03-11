import 'package:flutter/material.dart';
import 'package:wash_x/enum.dart';

class InputFieldInfo {
  InputFieldInfo(
      {this.type = InputFieldTypes.DEFAULT,
      this.labelText = '',
      this.value = '',
      this.isRequired = false,
      this.icon = const Icon(Icons.vpn_lock),
      this.isObscure = false,
      this.inputKeyboardType = TextInputType.text});
  InputFieldTypes type;
  String labelText;
  bool isObscure;
  bool isRequired;
  TextInputType inputKeyboardType;
  String value;
  Icon icon;
}
