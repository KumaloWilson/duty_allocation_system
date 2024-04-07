import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../api_services/employee_methods/employee.dart';
import '../../../models/employee_model.dart';
import '../../../providers/employee_provider.dart';
import '../../../utils/asset_utils/assets_util.dart';
import '../../../utils/colors/pallete.dart';
import '../../custom_animations/fade_in_slide_animation.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/loading_widgets/custom_loader.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? selectedRole;
  String? selectedDept;


  List<String> employeeRoles = [
    "RGN",
    "Midwife",
    "Nurse Aid",
    "General Hand",
    "Student",
    "Pharm Tech",
    "Lab Tech",
    "Dentist",
    "Primary Counsellor",
    "Data Entry Clerk",
    "Ambu. Drivers",
    "RadioGrapher"

  ];

  List<String> employeeDept = [
    "ward",
    "maternity",
    "laboratory",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                          radius: screenWidth * 0.15,
                          child: Lottie.asset(Assets.addEmployeesAnimation),
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
                        height: screenHeight * 0.2,
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
                                'Add Employee',
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
                                labelText: 'First Name',
                                controller: _firstNameController,
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FadeInSlide(
                              duration: 0.6,
                              child: CustomTextField(
                                labelText: 'Last Name',
                                controller: _lastNameController,
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),


                            const SizedBox(
                              height: 8,
                            ),
                            FadeInSlide(
                              duration: 0.8,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedDept,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDept = newValue!;
                                    });
                                  },
                                  items: employeeDept.map((String dept) {
                                    return DropdownMenuItem<String>(
                                      value: dept,
                                      child: Text(
                                        Helpers.capitalizeFirstLetter(dept)
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  iconEnabledColor: Colors.black,
                                  icon: Icon(Icons.arrow_drop_down),
                                  hint: Text(
                                    'Dept',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  elevation: 16,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            FadeInSlide(
                              duration: 1.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedRole,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedRole = newValue!;
                                    });
                                  },
                                  items: employeeRoles.map((String dept) {
                                    return DropdownMenuItem<String>(
                                      value: dept,
                                      child: Text(dept),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  iconEnabledColor: Colors.black,
                                  icon: Icon(Icons.arrow_drop_down),
                                  hint: Text(
                                    'Role',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  elevation: 16,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 24,
                            ),
                            FadeInSlide(
                              duration: 1.2,
                              child: CustomButton(
                                  btnColor: Pallete.primaryColor,
                                  width: screenWidth,
                                  borderRadius: 10,
                                  child: Text(
                                    'Add Employee',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: _addEmployee
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getImageAsset(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return Assets.student;
      case 'rgn':
        return Assets.nurse;
      case 'nurse aid':
        return Assets.nurseaid;
      case 'general hand':
        return Assets.generalhand;
      default:
        return Assets.nurseaid;
    }
  }


  void _addEmployee() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const CustomLoader(message: 'Adding Employee');
      },
    );

    try {
      await EmployeeServices.addEmployee(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        role: selectedRole!,
        department: selectedDept!,
      );

      // Fetch updated list of employees
      final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
      await employeeProvider.fetchEmployees(dept: 'ward');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success',
            message: 'Employee Added Successfully',
            contentType: ContentType.success,
          ),
        ),
      );


      Navigator.of(context).pop();
      Navigator.of(context).pop();


    } catch (error) {
      // Handle error
      print('Error adding employee: $error');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message: 'Failed to add employee. Please try again.',
            contentType: ContentType.failure,
          ),
        ),
      );
    }
  }
}
