import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/model/user_profile.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_config/responsive_config.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  final Function onTap;
  const ChatTile({super.key, required this.userProfile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(

          onTap: (){
            onTap();
          },
          dense: false,
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              userProfile.pfpURL!,
            ),
          ),
          title: Text(
            userProfile.name!,
            style: AppStyles.w400f12poppins.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8),),
        Divider(color: kBlackColor.withOpacity(0.4),),
      ],
    );
  }
}
