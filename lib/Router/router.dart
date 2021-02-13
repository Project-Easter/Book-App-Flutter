import 'package:books_app/Screens/Auth/login.dart';
import 'package:books_app/screens/chat_screen.dart';
import 'package:books_app/screens/settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Screens/Auth/confirmOTP.dart';
import 'package:books_app/Screens/Auth/register.dart';
import 'package:books_app/Screens/Auth/signup.dart';
import 'package:books_app/Screens/Auth/confirmemail.dart';
import 'package:books_app/screens/initial_screen.dart';
import 'package:books_app/Screens/Dashboard.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startupPage:
        return MaterialPageRoute(builder: (_) => InitialScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case confirmOTP:
        return MaterialPageRoute(
            builder: (_) => ConfirmScreen(settings.arguments));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case userName:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case confirmEmail:
        return MaterialPageRoute(builder: (_) => ConfirmEmailScreen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case chatscreen:
        return MaterialPageRoute(builder: (_) => ChatScreen());
      //testing the screen
       case setscreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}