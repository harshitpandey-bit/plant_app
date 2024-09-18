import 'package:flutter/material.dart';

class CustomWidgets {

  AppBar customAppBar( {
    required String title,
    IconData? leading,
    List<Widget>? actions,
  }) {
    return AppBar(

      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
      leading: leading != null ? Icon(leading) : null,
      actions: actions != null
          ? [...actions, SizedBox(width: 20)]
          : [],
    );
  }
}
