
import 'package:ar_chat/view/authentication/login_screen.dart';
import 'package:ar_chat/view/authentication/signup_screen.dart';
import 'package:ar_chat/view/home/home_screen.dart';
import 'package:ar_chat/view/splash/splash_screen.dart';
import 'package:ar_chat/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    AppLinks.splashScreen: (_) => const SplashScreen(),
    AppLinks.signUpScreen: (_) => const SignupScreen(),
    AppLinks.loginScreen: (_) => const LoginScreen(),
    AppLinks.homeScreen: (_) => const HomeScreen(),
    AppLinks.welcomeScreen: (_) => const WelcomeScreen(),
  };
}

class AppLinks {
  static const splashScreen = '/splash_screen';
  static const loginScreen = '/login_screen';
  static const signUpScreen = '/signup_screen';
  static const homeScreen = '/home_screen';
  static const welcomeScreen = '/welcome_screen';

}
