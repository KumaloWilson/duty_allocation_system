import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/api_services/api_methods.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/employee_model.dart';
import '../../../providers/employee_provider.dart';
import '../../widgets/custom_snackbar.dart';
import 'table_preview_screen.dart';

class DutyAllocationScreen extends StatefulWidget {
  const DutyAllocationScreen({super.key});

  @override
  _DutyAllocationScreenState createState() => _DutyAllocationScreenState();
}

class _DutyAllocationScreenState extends State<DutyAllocationScreen> {
  TextEditingController notesController = TextEditingController();
  TextEditingController owingController = TextEditingController();
  String? selectedEmployee;
  String? selectedDept;

  List<String> dutyOptions = [
    "all day",
    "12.30hrs",
    "night duty",
    "Day off",
    "Nights off",
    "Sick Leave",
    "Vacation Leave",
    "Study Leave",
  ];

  List<String> deptOptions = [
    "OPD Peads",
    "OPD Adults",
    "Wards",
  ];

  List<String> selectedDutyOptions = List.filled(7, "all day");

  @override
  void initState() {
    super.initState();
    setState(() {
      ApiAssistants.fetchEmployees(employeeNames);
    });
  }

  List<String> employeeNames = [];

  @override
  Widget build(BuildContext context) {
    var employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey.shade200
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 15,
                            blurRadius: 1,
                            offset: const Offset(-3, -3),
                          ),

                          BoxShadow(
                            color: Colors.grey.shade50,
                            spreadRadius: 15,
                            blurRadius: 7,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        border: Border.all(
                            color: Colors.white,
                            width: 1
                        )
                    ),

                    child: Column(
                      children: [
                        DropdownButton<String>(
                          value: selectedEmployee,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedEmployee = newValue!;
                            });
                          },
                          items: employeeNames.map((String employeeName) {
                            return DropdownMenuItem<String>(
                              value: employeeName,
                              child: Text(employeeName),
                            );
                          }).toList(),
                        ),

                        DropdownButton<String>(
                          value: selectedDept,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDept = newValue!;
                            });
                          },
                          items: deptOptions.map((String dept) {
                            return DropdownMenuItem<String>(
                              value: dept,
                              child: Text(dept),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 8,
              ),

              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey.shade200
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 15,
                            blurRadius: 1,
                            offset: const Offset(-3, -3),
                          ),

                          BoxShadow(
                            color: Colors.grey.shade50,
                            spreadRadius: 15,
                            blurRadius: 7,
                            offset: const Offset(3, 3),
                          ),
                        ],
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < 7; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                i == 0 ? 'Monday'
                                  : i == 1 ? 'Tuesday'
                                  : i == 2 ? 'Wednesday'
                                  : i == 3 ? 'Thursday'
                                  : i == 4 ? 'Friday'
                                  : i == 5 ? 'Saturday'
                                  : 'Sunday'
                              ),
                              DropdownButton<String>(
                                value: selectedDutyOptions[i],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDutyOptions[i] = newValue!;
                                  });
                                },
                                items: dutyOptions.map((String dutyOption) {
                                  return DropdownMenuItem<String>(
                                    value: dutyOption,
                                    child: Text(dutyOption),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),


              SizedBox(
                width: 8,
              ),


              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.grey.shade200
                      )
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 15,
                            blurRadius: 1,
                            offset: const Offset(-3, -3),
                          ),

                          BoxShadow(
                            color: Colors.grey.shade50,
                            spreadRadius: 15,
                            blurRadius: 7,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        border: Border.all(
                            color: Colors.white,
                            width: 1
                        )
                    ),
                    child: Column(
                      children: [

                        CustomButton(
                          buttonText: 'Add to Roster',
                          buttonTextColor: Colors.white,
                          neumophismPrimaryColor: Colors.black12,
                          neumophismSecondaryColor: Colors.white30,
                          buttonIcon: Icons.check,
                          buttonColor: Colors.green.withOpacity(0.9),
                          onTap: () {

                            if (selectedEmployee == '' || selectedEmployee == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Input Error',
                                      message: 'Please selected an employee',
                                      contentType: ContentType.failure,
                                    ),
                                  )
                              );
                            }

                            else if (selectedDept == '' || selectedDept == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Input Error',
                                      message: 'Please select a department',
                                      contentType: ContentType.failure,
                                    ),
                                  )
                              );
                            }

                            else {

                              employeeProvider.addEmployeeToRoster(Helpers.addToRoster(selectedEmployee!, selectedDept!, selectedDutyOptions));

                              selectedEmployee = null;
                              selectedDept = null;

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Success',
                                      message: 'Employee Added to Rooster',
                                      contentType: ContentType.success,
                                    ),
                                  )
                              );
                            }
                          },
                        ),

                        CustomButton(
                          buttonText: 'Preview',
                          buttonTextColor: Colors.white,
                          neumophismPrimaryColor: Colors.black12,
                          neumophismSecondaryColor: Colors.white30,
                          buttonIcon: Icons.preview,
                          buttonColor: Colors.blue.withOpacity(0.9),
                          onTap: () {
                            Helpers.temporaryNavigator(context, const TablePreviewScreen());
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
