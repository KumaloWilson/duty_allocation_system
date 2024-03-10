import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:duty_allocation_system/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/asset_utils/assets_util.dart';
import '../authorization_screens/auth_handler.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Assets.splashLogo,
      splashIconSize: 350,
      backgroundColor: Colors.white,

      screenFunction: () async{
        return const AuthHandler();
      },
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade
    );
  }
}
