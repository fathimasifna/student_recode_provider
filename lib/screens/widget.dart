import 'package:flutter/material.dart';

class Custom extends InputDecoration {
  final String text;
  final IconData iconData;
  Custom(this.text, this.iconData)
      : super(
            border: const OutlineInputBorder(),
            label: Text(text),
            prefixIcon: Icon(iconData));
}
