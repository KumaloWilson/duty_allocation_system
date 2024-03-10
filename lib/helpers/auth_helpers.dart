import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platform_x_universal/global/global.dart';
import 'package:platform_x_universal/helpers/genenal_helpers.dart';
import 'package:platform_x_universal/views/screens/agent_module/mainscreen/agent_mainscreen.dart';
import 'package:platform_x_universal/views/screens/customer_module/mainscreen/customer_mainscreen.dart';
import 'package:platform_x_universal/views/screens/delivery_module/delivery_mainscreen/mainscreen.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/auth_handler.dart';
import 'package:platform_x_universal/views/screens/universal_screens/usertype/select_user_type.dart';

import '../views/screens/universal_screens/authorization_screens/email_verification_success.dart';
import '../views/screens/universal_screens/authorization_screens/email_verification_screen.dart';

class AuthHelpers {
  static Future<void> handleEmailVerification(BuildContext context, User user) async {
    if (!user.emailVerified) {
      Helpers.permanentNavigator(context, EmailVerificationScreen(user: user));
    } else {
      Helpers.permanentNavigator(context, const AuthHandler());
    }
  }

  static Future<void> checkEmailVerification({required BuildContext context, required User currentUser}) async {
    await currentUser.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      Helpers.permanentNavigator(context, const AuthHandler());
    }
  }
  
  static setTimerForAutoRedirect(BuildContext context) {
    const Duration timerPeriod = Duration(seconds: 5); // Change the timer period as needed
    Timer.periodic(
      timerPeriod,
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;

        if (user?.emailVerified ?? false) {
          Helpers.permanentNavigator(
              context, const AccountVerificationSuccessful());
          timer.cancel(); // Stop the timer once verification is successful
        }
      },
    );
  }

  static Future<String?> getCurrentUserToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? token = await user.getIdToken();
        return token;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user token: $e');
      return null;
    }
  }

  static Widget getSelectedUserRole() {
    switch (userRole) {
      case UserRole.agent:
        return const AgentMainScreen();
      case UserRole.customer:
        return const CustomerMainScreen();
      case UserRole.delivery:
        return const DeliveryMainScreen();
      case UserRole.distributor:
        return const AgentMainScreen();
      default:
        return const RoleSelectionScreen();
    }
  }

}
