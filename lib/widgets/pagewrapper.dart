import 'package:flutter/material.dart';
import 'package:psettracker/static/settings.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final BuildContext context;
  PageWrapper({this.child, this.context});

  @override
  Widget build(BuildContext context) {
    context = this.context;
    
    return Scaffold(
      backgroundColor: Settings.darkTheme ? Colors.black87 : Colors.transparent,
      body: SafeArea(
        top: true,
        child: child,
      ),
    );   
  }
}