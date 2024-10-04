import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AlertService {
  final GetIt _getIt = GetIt.instance;

  AlertService() {}

  void showToast(
      {required String message, IconData icon = CupertinoIcons.info, required BuildContext context, Color color = kWhiteColor}) {
    try {
      DelightToastBar.removeAll();
      DelightToastBar(
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (BuildContext context) {
          return ToastCard(
            color: color,
              leading: Icon(
                icon,
                size: 24,
              ),
              title: Text(
                message,
                style: AppStyles.w500f15poppins.copyWith(
                  color: kBlackColor,
                ),
              ));
        },
      ).show(context);
    } catch (e) {
      print("Error in showToast: $e");
    }
  }
}
