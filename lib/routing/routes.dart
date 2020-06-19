import 'package:flutter/material.dart';
import 'package:psettracker/loadpage.dart';
import 'package:psettracker/pages/dashboard.dart';
import 'package:psettracker/pages/day1.dart';
import 'package:psettracker/pages/loginpage.dart';
import 'package:psettracker/pages/registerpage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    
    switch (settings.name) {
      
      case '/':
      case '/login/loginpage':
        return MaterialPageRoute(builder: (_) => LoginPage(), settings: RouteSettings(name: 'login'));

      case '/login/registerpage':
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case '/load':
        return MaterialPageRoute(builder: (_) => LoadPage());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard(), settings: RouteSettings(name: 'dashboard'));

      case '/pset/day':
        return MaterialPageRoute(builder: (_) => DayProblems(day: args as int,), settings: RouteSettings(name: 'pset/day'));

    }
  }
}