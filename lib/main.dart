import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/pages/loginpage.dart';
import 'package:psettracker/routing/routes.dart';
import 'package:psettracker/static/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Problemsets alpha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme).
          apply(
            bodyColor: Settings.darkTheme ? Colors.white70 : Colors.black,
            displayColor: Settings.darkTheme ? Colors.white70 : Colors.black,
          )
      ),
      
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
