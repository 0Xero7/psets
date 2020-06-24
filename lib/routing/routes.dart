import 'package:flutter/material.dart';
import 'package:psettracker/loadpage.dart';
import 'package:psettracker/pages/about.dart';
import 'package:psettracker/pages/auth/checkauth.dart';
import 'package:psettracker/pages/contributors.dart';
import 'package:psettracker/pages/dashboard.dart';
import 'package:psettracker/pages/day1.dart';
import 'package:psettracker/pages/loginpage.dart';
import 'package:psettracker/pages/registerpage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    
    switch (settings.name) {
      
      case '/':
        return MaterialPageRoute(builder: (_) => CheckAuth());
        
      case '/login/loginpage':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/login/registerpage':
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case '/load':
        return MaterialPageRoute(builder: (_) => LoadPage());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());

      case '/pset/day':
        return MaterialPageRoute(builder: (_) => DayProblems(args as Map<String, dynamic>));

      case '/about/contributors':
        return MaterialPageRoute(builder: (_) => Contributors());

      case '/about/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
    }
  }
}