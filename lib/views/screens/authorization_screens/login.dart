import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platform_x_universal/api_services/auth_methods/authorization_services.dart';
import 'package:platform_x_universal/helpers/genenal_helpers.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/utils/colors/pallete.dart';
import 'package:platform_x_universal/views/custom_animations/fade_in_slide.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/auth_handler.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/forgot_password.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/signup.dart';
import 'package:platform_x_universal/views/widgets/custom_button.dart';
import 'package:platform_x_universal/views/widgets/custom_text_field.dart';
import '../../../widgets/loading_widgets/custom_loader.dart';


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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            FadeInSlide(
                duration: .6,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  child: Image.asset(Assets.blueLogo),
                )
            ),
            const SizedBox(
              height: 20,
            ),
            FadeInSlide(
              duration: .8,
              child: Container(
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
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: Pallete.lightPrimaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: emailController,
                      labelText: 'Email Address',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      controller: passwordNameController,
                      obscureText: true,
                      labelText: 'password',
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
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
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
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
                  ],
                ),
              ),
            ),
            FadeInSlide(
              duration: .10,
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
                        width: screenWidth * 0.42,
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
                        width: screenWidth * 0.42,
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
    );
  }
}
