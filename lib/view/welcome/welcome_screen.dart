import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/view/authentication/login_screen.dart';
import 'package:ar_chat/view/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_config/responsive_config.dart';

import '../../components/custom_action_button.dart';
import '../../generated/assets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(60),
            left: getProportionateScreenHeight(16),
            right: getProportionateScreenWidth(16),
            bottom: getProportionateScreenHeight(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "AR Chat",
              style: AppStyles.w600f15BtnTxt.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: kWhiteColor,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(147),
            ),
            Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Let's Share Our ",
                    style: AppStyles.w400f20White,
                  ),
                  TextSpan(
                    text: "Thoughts",
                    style: AppStyles.w400f25White,
                  ),
                ])),
                Text(
                  "Comfortably",
                  style: AppStyles.w500f12White.copyWith(
                    fontSize: 39,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(146),
            ),
            Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(32),
                ),
                CustomActionButton(
                  showGradient: false,
                  backgroundColor: const Color(0XFFFDFDFD),
                  buttonTextStyle: AppStyles.w600f15BtnTxt,
                  buttonText: 'Sign up',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(16),
                ),
                CustomActionButton(
                  buttonText: 'Login in',
                  showGradient: false,
                  backgroundColor: const Color(0XFFFDFDFD),
                  buttonTextStyle: AppStyles.w600f15BtnTxt,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(24),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }





}
