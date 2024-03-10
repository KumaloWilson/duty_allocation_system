
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../helpers/helper_methods.dart';
import '../../../utils/asset_utils/assets_util.dart';
import '../../../utils/colors/pallete.dart';
import '../../widgets/custom_button.dart';
import 'auth_handler.dart';

class AccountVerificationSuccessful extends StatelessWidget {
  const AccountVerificationSuccessful({super.key});


  @override
  Widget build(BuildContext context) {String? sentTo;
  double screenWidth = MediaQuery.sizeOf(context).width;


  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
          ),

          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                          Assets.successfulAnimation,
                          width: 200
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: screenWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        'Verification Successful',
                        style: GoogleFonts.poppins(
                            color: Pallete.lightPrimaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(
                        'Congratulations your account has been activated.Continue to start Shopping and Experience a world of unrivaled Deals and personalized Offers.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Pallete.lightPrimaryTextColor,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(
                        height: 40,
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

                          onTap: () => Helpers.permanentNavigator(context, AuthHandler())
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }
}
