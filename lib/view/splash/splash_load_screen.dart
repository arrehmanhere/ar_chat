import 'dart:async';

import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/view/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_config/responsive_config.dart';
import '../../generated/assets.dart';

class SplashLoadScreen extends StatefulWidget {
  const SplashLoadScreen({super.key});

  @override
  State<SplashLoadScreen> createState() => _SplashLoadScreenState();
}

class _SplashLoadScreenState extends State<SplashLoadScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 800),(){
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>const WelcomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0XFFFDFDFD),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.iconsAppIcon,
                width: getProportionateScreenWidth(92),
                height: getProportionateScreenHeight(103),
              ),
              const SizedBox(
                height: 15,
              ),
              const CupertinoActivityIndicator(
                radius: 12,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
