import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  PageWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: child,
      ),
    );   
  }
}