import 'package:flutter/material.dart';
import 'package:psettracker/static/settings.dart';

class CustomBack extends StatelessWidget {
  final Function callback;
  CustomBack(this.callback);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: Settings.darkTheme ? Colors.black54 : Colors.black12,
        child: InkWell(
          onTap: () { 
            if (callback != null) callback();
            Navigator.pop(context); 
          },
          child: Icon(Icons.arrow_back, color: (Settings.darkTheme ? Colors.white : Colors.black),),
        )
      ),
    );   
  }
}