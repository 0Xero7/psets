import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psettracker/pages/loginpage.dart';
import 'package:psettracker/routing/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Problemset Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)
      ),
      
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/login/loginpage',
    );
  }
}
