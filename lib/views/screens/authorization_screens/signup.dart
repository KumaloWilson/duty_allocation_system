import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_controller.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platform_x_universal/helpers/genenal_helpers.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/utils/colors/pallete.dart';
import 'package:platform_x_universal/views/custom_animations/fade_in_slide.dart';
import 'package:platform_x_universal/views/widgets/custom_button.dart';
import 'package:platform_x_universal/views/widgets/custom_text_field.dart';

import '../../delivery_module/auth/personal_info_screen.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PhoneNumberInputController? phoneNumberController;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController = PhoneNumberInputController(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    phoneNumberController!.dispose();
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
              height: 16,
            ),
            FadeInSlide(
              duration: .6,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70,
                child: Image.asset(
                    Assets.blueLogo
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FadeInSlide(
              duration: .8,
              child: Container(
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
                      'Register',
                      style: GoogleFonts.poppins(
                          color: Pallete.lightPrimaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
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
                      controller: userNameController,
                      labelText: 'Username',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),


                    PhoneNumberInput(
                      initialCountry: 'ZW',
                      locale: 'fr',
                      errorText: 'Invalid Phone Number',
                      controller: phoneNumberController,
                      countryListMode: CountryListMode.bottomSheet,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Pallete.primaryColor)
                      ),
                      allowPickFromContacts: false,
                      inputTextStyle: GoogleFonts.poppins(
                          color: Pallete.primaryColor,
                          fontSize: 12
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
                          'Continue',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                          ),
                        ),

                        onTap: () => Helpers.permanentNavigator(context, AdditionalPersonalInfoScreen(
                            email: emailController.text.trim(),
                            username: userNameController.text.trim(),
                            phoneNumber: phoneNumberController!.phoneNumber.toString().trim()
                        ))
                    ),


                  ],
                ),
              ),
            ),
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
                  'SignUp with',
                  style: GoogleFonts.poppins(
                    color: Pallete.lightPrimaryTextColor,
                    fontSize: 12
                  ),
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
                Image.asset(
                  Assets.googleIcon,
                  width: 40,
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
                  style: GoogleFonts.poppins(
                      color: Pallete.lightPrimaryTextColor
                  ),
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
              onTap: () => Helpers.permanentNavigator(context, const Login()),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Pallete.lightPrimaryTextColor
                    ),
                    children: [
                      const TextSpan(
                          text: "Already have an account? "
                      ),

                      TextSpan(
                          text: " Login",
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
                color: Pallete.lightPrimaryTextColor,
                fontSize: 9.61
              ),
            )


          ],
        ),
      ),

    );
  }
}
