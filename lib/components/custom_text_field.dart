import 'dart:developer';

import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/generated/assets.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_config/responsive_config.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool? filled;
  final Color? fillColor;
  final bool? enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? focusedBorderColor, bordercolor;
  final Color? prefixIconColor;
  final double? borderRadius;
  final double? textHorizontalPadding;
  final int? maxLines, maxLength;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? autoFocus, readOnly;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final BoxShadow? boxShadow;

  const CustomTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        this.filled,
        this.fillColor,
        this.enabled,
        this.focusedBorderColor,
        this.bordercolor,
        this.prefixIcon,
        this.prefixIconColor,
        this.suffixIcon,
        this.borderRadius,
        this.maxLines,
        this.keyboardType,
        this.validator,
        required this.obscureText,
        this.autoFocus,
        this.readOnly,
        this.onChanged,
        this.onSubmitted,
        this.onTap,
        this.maxLength,
        this.inputFormatters,
        this.textHorizontalPadding = 18, this.boxShadow, this.hintStyle});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidePassword = true;

  get key => widget.key;

  get validator => widget.validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                boxShadow: [
                  widget.boxShadow ?? const BoxShadow(
                    color: Color(0x33C1C1C1),
                    offset: Offset(0, 18),
                    blurRadius: 50,
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextFormField(
                maxLength: widget.maxLength,
                onTap: widget.onTap,
                onChanged: (value) {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                },
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                  TextEditingController().clear();
                },
                onFieldSubmitted: widget.onSubmitted,
                inputFormatters: widget.inputFormatters,
                maxLines: widget.maxLines ?? 1,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: widget.autoFocus ?? false,
                readOnly: widget.readOnly ?? false,
                obscureText: widget.obscureText && hidePassword,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                // validator: widget.validator,
                style: AppStyles.w400f12poppins,
                cursorColor: kBlackColor.withOpacity(0.7),
                decoration: InputDecoration(
                  counter: const SizedBox.shrink(),
                  border: InputBorder.none,
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(24),
                      right: getProportionateScreenWidth(12),
                    ),
                    child: widget.prefixIcon,
                  )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Padding(
                    padding: const EdgeInsets.only(right: 29),
                    child: widget.suffixIcon,
                  )
                      : widget.obscureText
                      ? InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                      log('Hide Password: ${hidePassword && widget.obscureText}');
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: getProportionateScreenWidth(24)),
                        child: hidePassword && widget.obscureText
                            ? SvgPicture.asset(Assets.iconsClosedEyeIcon)
                            : SvgPicture.asset(Assets.iconsOpenEyeIcon)),
                  )
                      : null,
                  contentPadding: EdgeInsets.symmetric(horizontal: widget.textHorizontalPadding!, vertical: 18),
                  prefixIconColor: widget.prefixIconColor,
                  errorStyle: AppStyles.w400f12poppins.copyWith(color: kErrorColor),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ?? AppStyles.w400f11poppins.copyWith(
                    color: kGrey4Color,
                  ),
                  filled: true,
                  fillColor: widget.fillColor ?? kWhiteColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: widget.focusedBorderColor ?? Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 30),
                child: Text(
                  field.errorText!,
                  style: AppStyles.w400f12poppins.copyWith(color: kErrorColor),
                ),
              ),
          ],
        );
      },
    );
  }
}
