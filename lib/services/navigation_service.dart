import 'package:ar_chat/view/authentication/login_screen.dart';
import 'package:ar_chat/view/authentication/signup_screen.dart';
import 'package:ar_chat/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class NavigationService{
  late GlobalKey<NavigatorState> _navigationKey;
  final Map<String,Widget Function(BuildContext)> _routes = {
    '/login' : (context) => LoginScreen(),
    '/home' : (context) => HomeScreen(),
    '/signup' : (context) => SignupScreen(),
  };

  GlobalKey<NavigatorState> get navigatorKey{
    return _navigationKey;
  }

  Map<String,Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService(){
    _navigationKey = GlobalKey<NavigatorState>();
  }
}