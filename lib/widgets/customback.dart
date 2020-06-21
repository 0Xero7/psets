
import 'dart:html';

import 'package:flutter/material.dart';

class CustomBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        borderRadius: BorderRadius.circular(40),
        child: InkWell(
          onTap: () { Navigator.pop(context); },
          child: Icon(Icons.arrow_back),
        )
      ),
    );   
  }
}