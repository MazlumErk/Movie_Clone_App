import 'package:flutter/material.dart';
import 'TextStyles.dart';

class LoginTextFieldDecorations {
  static OutlineInputBorder loginTextFieldFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );

  static OutlineInputBorder loginTextFieldEnabledBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
  );

}
