import 'package:duty_allocation_system/views/screens/authorization_screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../api_services/auth_methods/authorization_services.dart';
import '../../../helpers/helper_methods.dart';
import '../../../utils/asset_utils/assets_util.dart';
import '../../../utils/colors/pallete.dart';
import '../../custom_animations/fade_in_slide_animation.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/custom_loader.dart';
import 'auth_handler.dart';
import 'forgot_password.dart';
import 'login.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();

  
  @override
  void dispose() {
    emailController.dispose();
    passwordNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidth * 0.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInSlide(
                      duration: 1.2,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: screenWidth * 0.12,
                        child: Lottie.asset(Assets.registration),
                      )
                  ),
                ],
              ),
            ),
            FadeInSlide(
              duration: 1,
              child: SizedBox(
                width: screenWidth * 0.6,
                height: screenHeight,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        'assets/images/logo.png',
                      )
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, -5),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          FadeInSlide(
                            duration: 0.2,
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                  color: Pallete.lightPrimaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FadeInSlide(
                            duration: 0.4,
                            child: CustomTextField(
                              controller: emailController,
                              labelText: 'Email Address',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FadeInSlide(
                            duration: 0.6,
                            child: CustomTextField(
                              controller: passwordNameController,
                              obscureText: true,
                              labelText: 'password',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          FadeInSlide(
                            duration: 0.8,
                            child: CustomButton(
                                btnColor: Pallete.primaryColor,
                                width: screenWidth,
                                borderRadius: 10,
                                child: Text(
                                  'Log In',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: ()async{
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context){
                                        return const CustomLoader(
                                            message: 'Logging in'
                                        );
                                      }
                                  );
                                  await AuthServices.login(emailAddress: emailController.text.trim(), password: passwordNameController.text.trim());

                                  Helpers.back(context);

                                  Helpers.temporaryNavigator(context, const AuthHandler());
                                }
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FadeInSlide(
                            duration: 1.0,
                            child: GestureDetector(
                              onTap: () => Helpers.temporaryNavigator(context, ForgotPasswordScreen()),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Pallete.lightPrimaryTextColor),
                                    children: [
                                      TextSpan(
                                          text: "Forgot Password?",
                                          style: GoogleFonts.poppins(
                                              color: Pallete.primaryColor,
                                              fontWeight: FontWeight.w400
                                          )
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInSlide(
                      duration: 1.2,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.25,
                                child: const Column(
                                  children: [
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                ' Login with',
                                style: GoogleFonts.poppins(
                                    color: Pallete.lightPrimaryTextColor, fontSize: 12),
                              ),
                              SizedBox(
                                width: screenWidth * 0.25,
                                child: const Column(
                                  children: [
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async{

                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context){
                                        return const CustomLoader(
                                            message: 'Logging in'
                                        );
                                      }
                                  );

                                  await AuthServices.signInWithGoogle();

                                  Helpers.back(context);

                                  Helpers.temporaryNavigator(context, const AuthHandler());



                                },
                                child: Image.asset(
                                  Assets.googleIcon,
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              const Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              const Icon(
                                FontAwesomeIcons.apple,
                                size: 40,
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.28,
                                child: const Column(
                                  children: [
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'or',
                                style:
                                GoogleFonts.poppins(color: Pallete.lightPrimaryTextColor),
                              ),
                              SizedBox(
                                width: screenWidth * 0.28,
                                child: const Column(
                                  children: [
                                    Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          GestureDetector(
                            onTap: () => Helpers.permanentNavigator(context, const SignUp()),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Pallete.lightPrimaryTextColor
                                  ),
                                  children: [
                                    const TextSpan(text: "Don't have an Account? "),
                                    TextSpan(
                                        text: " Register",
                                        style: GoogleFonts.poppins(
                                            color: Pallete.primaryColor,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                  ]
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            'By proceeding you consent to get calls, WhatsApp or SMS messages including by automated means from Markiti and its affiliated to the number provided',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Pallete.lightPrimaryTextColor, fontSize: 9.61),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
