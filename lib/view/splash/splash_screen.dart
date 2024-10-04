import 'dart:async';

import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/generated/assets.dart';
import 'package:ar_chat/view/splash/splash_load_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_config/responsive_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashLoadScreen(),
          ));
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesSplashScreenBg),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.iconsLogoWhite,
                width: getProportionateScreenWidth(132),
                height: getProportionateScreenHeight(146),
              ),
               SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Text(
                "Let's Chat",
                style: AppStyles.w700f28White,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
