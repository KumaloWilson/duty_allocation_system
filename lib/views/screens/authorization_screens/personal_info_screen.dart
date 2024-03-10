
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/helper_methods.dart';
import '../../../utils/colors/pallete.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'create_password.dart';

class AdditionalPersonalInfoScreen extends StatelessWidget {
  final String email;
  final String username;
  final String phoneNumber;

  AdditionalPersonalInfoScreen({super.key, required this.email, required this.username, required this.phoneNumber});


  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  String? selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Pallete.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Let's get\nStarted",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Tell us a bit more about yourself and\n we'll get you started",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Divider(
                      thickness: 5,
                      color: Pallete.primaryColor,
                    ),
                  ],
                ),
              ),

              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.rectangle,
                  color: Colors.white,
                ),
              ),

              const Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Divider(
                      thickness: 5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 500,
        margin: const EdgeInsets.only(left: 16, right: 16),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Personal\nInformation',
              style: GoogleFonts.poppins(
                  color: Pallete.lightPrimaryTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Enter your name as it appears on your National Identity Card',
              style: GoogleFonts.poppins(
                color: Pallete.lightPrimaryTextColor,
                fontSize: 12,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            CustomTextField(
              controller: firstNameController,
              labelText: 'First Name',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            CustomTextField(
              controller: lastNameController,
              labelText: 'Last Name',
              obscureText: false,
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 8,
            ),


            GenderPickerWithImage(
              showOtherGender: true,
              verticalAlignedText: true,
              selectedGender: Gender.Male,
              selectedGenderTextStyle: TextStyle(
                  color: Pallete.primaryColor,
                  fontWeight: FontWeight.bold
              ),
              unSelectedGenderTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal),
              onChanged: (Gender? gender) {
                selectedGender = gender.toString().split('.').last;
              },
              equallyAligned: true,
              animationDuration: const Duration(milliseconds: 300),
              isCircular: true,
              // default : true,
              opacityOfGradient: 0.4,
              padding: const EdgeInsets.all(3),
              size: 50, //default : 40
            ),

            const SizedBox(
                height: 16
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

                onTap: () => Helpers.temporaryNavigator(
                    context,
                    CreatePasswordScreen(
                        email: email,
                        username: username,
                        phoneNumber: phoneNumber,
                        fullName: '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                        dob: '15/09/1958',
                        gender: selectedGender!
                    )
                )
            ),

            const SizedBox(
              height: 300,
            )

          ],
        ),
      ),
    );
  }
}
