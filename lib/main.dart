import 'package:ar_chat/routes/routes.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/theme/theme.dart';
import 'package:ar_chat/utils/utils.dart';
import 'package:ar_chat/view/home/home_screen.dart';
import 'package:ar_chat/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_config/responsive_config.dart';

void main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

late AuthService _authService;

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _authService = GetIt.instance.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR Chat',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: AppRoutes.routes,
    );
  }
}
