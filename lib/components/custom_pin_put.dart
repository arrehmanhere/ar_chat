
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_config/responsive_config.dart';
class CustomPinPut extends StatefulWidget {

  const CustomPinPut({
    super.key,
  });

  @override
  State<CustomPinPut> createState() => _CustomPinPutState();
}

class _CustomPinPutState extends State<CustomPinPut> {
  FocusNode focusNode = FocusNode();

  final defaultPinTheme = const PinTheme(
    width: 45,
    height: 40,
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: 'poppins',
      color: Color(0XFF1F2025),
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0XFF78858D),
          width: 2,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      showCursor: true,
      cursor: Container(
        width: 1,
        height: 56,
        color: Colors.black,
        margin: EdgeInsets.only(
            bottom: getProportionateScreenHeight(10)),
      ),
    );
  }
}