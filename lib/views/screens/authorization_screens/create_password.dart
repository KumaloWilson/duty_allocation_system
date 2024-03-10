import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:platform_x_universal/api_services/auth_methods/authorization_services.dart';
import 'package:platform_x_universal/global/global.dart';
import 'package:platform_x_universal/helpers/genenal_helpers.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/auth_handler.dart';
import '../../../../utils/asset_utils/assets_util.dart';
import '../../../../utils/colors/pallete.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/loading_widgets/custom_loader.dart';
import '../../../widgets/custom_text_field.dart';

class CreatePasswordScreen extends StatelessWidget {
  final String email;
  final String username;
  final String phoneNumber;
  final String fullName;
  final String dob;
  final String gender;

  CreatePasswordScreen({super.key, required this.email, required this.username, required this.phoneNumber, required this.fullName, required this.dob, required this.gender});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String role = userRole.toString().split('.').last;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [

            CircleAvatar(
              radius: 120,
              backgroundColor: Colors.transparent,
              child: Lottie.asset(
                  Assets.createPasswordAnimation,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20
              ),

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
                    'Create a Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Pallete.lightPrimaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    'Password should contain at least one\nuppercase, lowercase, number\n and special characters',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Pallete.lightPrimaryTextColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextField(
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Create a password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  CustomTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    labelText: 'Confirm password',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomButton(
                      btnColor: Pallete.primaryColor,
                      width: screenWidth,
                      borderRadius: 10,
                      child: Text(
                        'SignUp',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),

                      onTap: () async{
                        if(passwordController.text.trim() != confirmPasswordController.text.trim()){
                          Fluttertoast.showToast(msg: 'Passwords don`t match');
                          return;
                        }


                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context){
                              return const CustomLoader(
                                  message: 'Creating your Account'
                              );
                            }
                        );

                        await AuthServices.signUpWithVerification(emailAddress: email, gender: gender, password: confirmPasswordController.text.trim(), userName: username, fullName: fullName, phoneNumber: phoneNumber, userRole: role, dob: dob);

                        Helpers.back(context);

                        Helpers.permanentNavigator(context, const AuthHandler());

                      },
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
