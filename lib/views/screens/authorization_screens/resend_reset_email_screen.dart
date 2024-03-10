import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:platform_x_universal/api_services/auth_methods/authorization_services.dart';
import 'package:platform_x_universal/helpers/genenal_helpers.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/utils/colors/pallete.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/login.dart';
import '../../../../helpers/auth_helpers.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/loading_widgets/custom_loader.dart';
import 'auth_handler.dart';
import 'create_password.dart';

class ResendResetEmailScreen extends StatelessWidget {
  final String email;

  const ResendResetEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {String? sentTo;
  double screenWidth = MediaQuery.sizeOf(context).width;


  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Row(
              children: [
                GestureDetector(
                  onTap: ()async{
                    await AuthServices.signOut();
                    Helpers.permanentNavigator(context, Login());
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pallete.primaryColor
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),

            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Lottie.asset(
                      Assets.otpAnimation,
                      width: 200
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    'Password Reset Email Sent',
                    style: GoogleFonts.poppins(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    '\n${email}\n',
                    style: GoogleFonts.poppins(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    'Your Account Security is our priority!. We`ve sent you a secure link to safely Change Your Password and keep\nYour Account Protected ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  CustomButton(
                      btnColor: Pallete.primaryColor,
                      width: screenWidth,
                      borderRadius: 10,
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),

                      onTap: () => Helpers.permanentNavigator(context, Login())
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  GestureDetector(
                    onTap: ()async{
                      await AuthServices.sendPasswordResetEmail(email: email);
                      Fluttertoast.showToast(msg: 'Password Reset Email Sent');
                    },
                    child: RichText(
                      text: TextSpan(
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Pallete.lightPrimaryTextColor
                          ),
                          children: [
                            const TextSpan(
                                text: "Didn't receive the email?"
                            ),

                            TextSpan(
                                text: " Resend",
                                style: GoogleFonts.poppins(
                                    color: Pallete.primaryColor,
                                    fontWeight: FontWeight.bold
                                )
                            )
                          ]
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}