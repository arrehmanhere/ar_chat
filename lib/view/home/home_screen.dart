import 'package:ar_chat/constants/app_styles.dart';
import 'package:ar_chat/model/user_profile.dart';
import 'package:ar_chat/routes/routes.dart';
import 'package:ar_chat/services/alert_service.dart';
import 'package:ar_chat/services/auth_service.dart';
import 'package:ar_chat/services/database_service.dart';
import 'package:ar_chat/theme/app_colors.dart';
import 'package:ar_chat/view/chats/chat_screen.dart';
import 'package:ar_chat/view/home/widgets/chat_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_config/responsive_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late AlertService _alertService;
  late DatabaseService _databaseService;

  @override
  void initState() {
    _authService = _getIt.get<AuthService>();
    _alertService = _getIt.get<AlertService>();
    _databaseService = _getIt.get<DatabaseService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: AppStyles.w500f15poppins.copyWith(
            color: kPrimaryColor,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool isLoggedOut = await _authService.signOut();
              if (isLoggedOut) {
                _alertService.showToast(
                    message: "Successfully logged out",
                    icon: Icons.check,
                    context: context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppLinks.welcomeScreen,
                  (route) => false,
                );
              }
            },
            icon: Icon(
              Icons.logout,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _databaseService.getUserProfiles(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Unable to load data",
                style: AppStyles.w400f12poppins,
              ),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final users = snapshot.data!.docs;
            return Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(16),
                right: getProportionateScreenWidth(16),
                top: getProportionateScreenHeight(20),
              ),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  UserProfile user = users[index].data();
                  return ChatTile(
                    userProfile: user,
                    onTap: () async {
                      final chatExists = await _databaseService.checkChatExists(
                          _authService.user!.uid, user.uid!);
                      if (!chatExists) {
                        await _databaseService.createNewChat(
                          _authService.user!.uid,
                          user.uid!,
                        );
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(chatUser: user),
                          ));
                    },
                  );
                },
              ),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 20,
              color: kPrimaryColor,
            ),
          );
        },
      ),
    );
  }
}
