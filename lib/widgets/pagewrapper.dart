import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final BuildContext context;
  PageWrapper({this.child, this.context});

  @override
  Widget build(BuildContext context) {
    context = this.context;
    
    return Scaffold(
      body: SafeArea(
        top: true,
        child: child,
      ),
    );   
  }
}