import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Widget content,
    {Color? backgroundColor, EdgeInsets? padding, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: content,
    backgroundColor: backgroundColor,
    padding: padding,
    action: action,
  ));
}
