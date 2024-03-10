import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platform_x_universal/helpers/auth_helpers.dart';
import 'package:platform_x_universal/views/screens/agent_module/mainscreen/agent_mainscreen.dart';
import 'package:provider/provider.dart';
import '../../../../global/global.dart';
import '../../../../providers/user_provider.dart';
import 'login.dart';

class AuthHandler extends StatelessWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final user = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UserProvider>(context, listen: false).updateUser(user);
            if (!user.emailVerified) {
              AuthHelpers.handleEmailVerification(context, user);
            }
          });
          return AuthHelpers.getSelectedUserRole();
        } else {
          return userRole != null ? const Login() : AuthHelpers.getSelectedUserRole();
        }
      },
    );
  }

}
