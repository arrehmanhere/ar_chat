
import 'package:flutter/material.dart';
import 'package:responsive_config/responsive_config.dart';

import '../constants/app_styles.dart';

class CustomActionButton extends StatelessWidget {
  final String buttonText;
  final Function()  onPressed;
  final TextStyle? buttonTextStyle;
 final bool? showGradient;
 final Color? backgroundColor;
 final bool isDisabled;

  const CustomActionButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonTextStyle, this.showGradient = true,  this.backgroundColor,  this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:   !isDisabled  ?   onPressed : null,
      child: Container(
        width: ResponsiveConfig.screenWidth,
        height: getProportionateScreenHeight(46),
        decoration: BoxDecoration(
          color:          !isDisabled ?  backgroundColor : const Color(0XFFE7E9ED),
          borderRadius: BorderRadius.circular(100),
          gradient:  showGradient! ? const LinearGradient(
            colors: [
              Color(0XFFB572F6),
              Color(0XFF9604E5),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,


          ) : null,
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style:      !isDisabled ?      buttonTextStyle ?? AppStyles.w400f20White : AppStyles.w600f15BtnTxt.copyWith(
            color: const Color(0XFF79838D),
          ),
        ),
      ),
    );
  }
}
