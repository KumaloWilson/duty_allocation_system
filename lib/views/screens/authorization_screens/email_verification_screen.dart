import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../helpers/auth_helpers.dart';
import '../../../helpers/helper_methods.dart';
import '../../../utils/asset_utils/assets_util.dart';
import '../../../utils/colors/pallete.dart';
import '../../widgets/custom_button.dart';
import 'login.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user;

  const EmailVerificationScreen({super.key, required this.user});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    AuthHelpers.setTimerForAutoRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: screenWidth * 0.35,
                      child: Lottie.asset(
                          Assets.otpAnimation,
                          width: 200
                      ),
                    ),

                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          SizedBox(
                            height: screenHeight * 0.2,
                          ),

                          Text(
                            'Verify you email address',
                            style: GoogleFonts.poppins(
                              color: Pallete.lightPrimaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          Text(
                            '\n${widget.user.email}\n',
                            style: GoogleFonts.poppins(
                              color: Pallete.lightPrimaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          Text(
                            'Congratulations your account awaits. Verify your email to start Shopping and Experience a world of unrivaled Deals and personalized Offers.',
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

                              onTap: () => AuthHelpers.checkEmailVerification(context: context, currentUser: _currentUser)
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          GestureDetector(
                            onTap: ()async{
                              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              Fluttertoast.showToast(msg: 'Verification Email Sent');
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
            ],
          ),
        ),
      ),
    );
  }
}