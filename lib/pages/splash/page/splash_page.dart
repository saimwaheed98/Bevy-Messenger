import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:bevy_messenger/bloc/cubits/auth_cubit.dart';
import 'package:bevy_messenger/core/di/service_locator_imports.dart';
import 'package:bevy_messenger/utils/app_text_style.dart';
import 'package:bevy_messenger/utils/colors.dart';
import 'package:bevy_messenger/utils/images_path.dart';
import 'package:bevy_messenger/utils/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../bloc/cubits/check_app_update_cubit.dart';
import '../../../bloc/cubits/internet_con_cubit.dart';
import '../../../routes/routes_imports.gr.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthCubit _authCubit = Di().sl<AuthCubit>();
  final InternetConCubit _internetConCbit = Di().sl<InternetConCubit>();
  final CheckAppUpdateCubit _checkAppUpdateCubit =
      Di().sl<CheckAppUpdateCubit>();

  @override
  initState() {
    initData();
    super.initState();
  }

  Future initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (Platform.isAndroid) {
      _checkAppUpdateCubit.checkForUpdate();
    }
    // _internetConCbit.checkInternetConnection();
    if (userId?.isEmpty ?? false) {
      _authCubit.getOtherUsernames();
    } else {
      _authCubit.getSelfInfo();
    }
    _navigateToNextScreen(userId);
  }

  _navigateToNextScreen(String? userId) async {
    Future.delayed(const Duration(seconds: 3), () {
      if (userId?.isNotEmpty ?? false) {
        AutoRouter.of(context).replace(const HomeBottomBarRoute());
      } else {
        AutoRouter.of(context).replace(const GetStartedPageRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 0.4],
            colors: [
              AppColors.secondaryColor.withOpacity(0.9),
              AppColors.primaryColor,
            ],
          ),
        ),
        child: SizedBox(
          height: getHeight(context),
          width: getWidth(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: 136,
                      width: 136,
                      child: Image.asset(AppImages.appIcon)),
                ),
                const SizedBox(height: 28),
                const Center(
                  child: AppTextStyle(
                      text: 'Bevy Messenger',
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
