import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/routes/routes.dart';
import 'package:ar_chat/services/alert_service.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late AlertService _alertService;

  @override
  void initState() {
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: AppStyles.w500f15poppins.copyWith(
            color: kPrimaryColor,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool isLoggedOut = await _authService.signOut();
              if (isLoggedOut) {
                _alertService.showToast(
                    message: "Successfully logged out",
                    icon: Icons.check,
                    context: context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppLinks.welcomeScreen,
                  (route) => false,
                );
              }
            },
            icon: Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Home Screen '),
      ),
    );
  }
}
