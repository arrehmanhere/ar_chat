import 'package:ar_chat/components/custom_action_button.dart';
import 'package:ar_chat/components/custom_text_field.dart';
import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/generated/assets.dart';
import 'package:ar_chat/routes/routes.dart';
import 'package:ar_chat/services/alert_service.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/utils/form_validate.dart';
import 'package:ar_chat/view/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_config/responsive_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;

  late AlertService _alertService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenWidth(16),
              right: getProportionateScreenWidth(16),
              top: getProportionateScreenHeight(40),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "AR Chat",
                        style: AppStyles.w600f24poppins,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(136),
                    ),
                    Center(
                      child: Text(
                          "Welcome Back!", style: AppStyles.w600f24poppins),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(6),
                    ),
                    Center(
                      child: Text("Login in your existing account",
                          style: AppStyles.w400f13poppins),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(48),
                    ),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Email address',
                      prefixIcon: SvgPicture.asset(
                        Assets.iconsMailIcon,
                      ),
                      obscureText: false,
                      validator: ValidateForm.validateEmail,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: SvgPicture.asset(
                        Assets.iconsLockIcon,
                      ),
                      obscureText: true,
                      validator: (p0) => ValidateForm.passwordValidator(p0),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(136),
                    ),
                    CustomActionButton(
                      buttonText: 'Login',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('Email: ${emailController.text}');
                          print('Password: ${passwordController.text}');
                          bool isLogin = await _authService.login(
                              emailController.text, passwordController.text);
                          print('isLogin: $isLogin');
                          if (isLogin) {
                            _alertService.showToast(
                                message: "Successfully to logged in",
                                icon: Icons.check_circle_outline,
                                context: context);
                            Navigator.pushNamedAndRemoveUntil(
                                context, AppLinks.homeScreen, (route) => false);
                          } else {
                            _alertService.showToast(
                                message: "Failed to login, Please try again",
                                context: context);
                          }
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const CustomBottomNavBar(
                        //         index: 0,
                        //       ),
                        //     ));
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(24),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: AppStyles.w400f12poppins.copyWith(
                            color: kGrey8EColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ));
                          },
                          style: TextButton.styleFrom(
                              overlayColor: Colors.grey,
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  vertical: -4, horizontal: -2)),
                          child: Text(
                            'Sign Up',
                            style: AppStyles.w400f12poppins.copyWith(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
