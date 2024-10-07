import 'dart:io';

import 'package:ar_chat/components/custom_action_button.dart';
import 'package:ar_chat/components/custom_text_field.dart';
import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/generated/assets.dart';
import 'package:ar_chat/model/user_profile.dart';
import 'package:ar_chat/routes/routes.dart';
import 'package:ar_chat/services/alert_service.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/services/database_service.dart';
import 'package:ar_chat/services/media_service.dart';
import 'package:ar_chat/services/storage_service.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/utils/form_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_config/responsive_config.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GetIt _getIt = GetIt.instance;
  late MediaService _mediaService;
  late AlertService _alertService;
  late AuthService _authService;
  late StorageService _storageService;
  late DatabaseService _databaseService;

  bool isLoading = false;

  @override
  void initState() {
    _mediaService = _getIt.get<MediaService>();
    _alertService = _getIt.get<AlertService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService>();
    _databaseService = _getIt.get<DatabaseService>();
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? selectedImage;

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16),
                top: getProportionateScreenHeight(8),
              ),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: !isLoading
                    ? Form(
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
                              height: getProportionateScreenHeight(20),
                            ),
                            InkWell(
                              onTap: () async {
                                File? file = await _mediaService.pickImage();
                                if (file != null) {
                                  setState(() {
                                    selectedImage = file;
                                  });
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                radius: getProportionateScreenWidth(50),
                                backgroundImage: selectedImage != null
                                    ? FileImage(selectedImage!)
                                    : const NetworkImage(
                                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Text("Let’s Get Started!",
                                style: AppStyles.w600f24poppins),
                            SizedBox(
                              height: getProportionateScreenHeight(6),
                            ),
                            Text("Create an account to get all features",
                                style: AppStyles.w400f13poppins),
                            SizedBox(
                              height: getProportionateScreenHeight(48),
                            ),
                            CustomTextField(
                              controller: nameController,
                              hintText: 'Enter Your Name',
                              prefixIcon: SvgPicture.asset(
                                Assets.iconsProfileIcon,
                                height: 20,
                                width: 20,
                              ),
                              obscureText: false,
                              validator: ValidateForm.userNameValidator,
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
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
                              validator: (p0) =>
                                  ValidateForm.passwordValidator(p0),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            CustomTextField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm password',
                              prefixIcon: SvgPicture.asset(
                                Assets.iconsLockIcon,
                              ),
                              obscureText: true,
                              validator: (p0) =>
                                  ValidateForm.confirmPasswordValidator(
                                      p0, passwordController.text),
                            ),
                            SizedBox(height: getProportionateScreenHeight(40)),
                            CustomActionButton(
                              buttonText: 'Sign Up',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (selectedImage == null) {
                                    _alertService.showToast(
                                        message: "Please select an image",
                                        context: context);
                                    return;
                                  }
                                  setState(() {
                                    isLoading = true;
                                  });
                                  bool isSignUp = await _authService.signUp(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (isSignUp) {
                                    String? profileUrl = await _storageService
                                        .uploadUserProfilePic(
                                            file: selectedImage!,
                                            uid: _authService.user!.uid);
                                    if (profileUrl != null) {
                                      await _databaseService.createUserProfile(
                                        userProfile: UserProfile(
                                          uid: _authService.user!.uid,
                                          name: nameController.text,
                                          pfpURL: profileUrl,
                                        ),
                                      );
                                      Navigator.pushNamedAndRemoveUntil(context, AppLinks.homeScreen, (route) => false);
                                      _alertService.showToast(
                                          message: "Successfully signed up",
                                          icon: Icons.check,
                                          context: context);
                                    } else {
                                      throw Exception("Unable to upload image");
                                    }
                                  }
                                  else {
                                    throw Exception("Unable to register user");
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
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
                                  'Already have an account?',
                                  style: AppStyles.w400f12poppins.copyWith(
                                    color: kGrey8EColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppLinks.loginScreen);
                                  },
                                  style: TextButton.styleFrom(
                                      overlayColor: Colors.grey,
                                      padding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          vertical: -4, horizontal: -4)),
                                  child: Text(
                                    'Login',
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
                        ))
                    : Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(350)),
                        child: const Center(
                          child: CupertinoActivityIndicator(
                            radius: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
