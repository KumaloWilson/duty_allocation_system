import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/api_services/employee_methods/employee.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/views/widgets/custom_button.dart';
import 'package:duty_allocation_system/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/duty_model.dart';
import '../../../providers/duty_provider.dart';
import '../../widgets/custom_snackbar.dart';
import 'table_preview_screen.dart';

class DutyAllocationScreen extends StatefulWidget {
  const DutyAllocationScreen({super.key});

  @override
  _DutyAllocationScreenState createState() => _DutyAllocationScreenState();
}

class _DutyAllocationScreenState extends State<DutyAllocationScreen> {
  TextEditingController? owingController = TextEditingController();
  String? selectedEmployee;
  String? selectedDept;

  List<String> dutyOptions = [
    "all day",
    "12.30hrs",
    "7AM to 7PM",
    "night duty",
    "Day off",
    "Nights off",
    "Sick Leave",
    "Vacation Leave",
    "Study Leave",
  ];

  List<String> deptOptions = [
    "OPD PEADS",
    "OPD Adults",
    "Wards",
  ];

  List<String> selectedDutyOptions = List.filled(7, "all day");

  List<String> employeeNames = [];

  @override
  void initState() {
    super.initState();
    getName(); // Call getName to fetch employee names
  }

  getName() async {
    var names = await EmployeeServices.getAllDeptEmployees(dept: 'Wards');
    setState(() {
      employeeNames = names.cast<String>(); // Assign the fetched names to employeeNames
    });
  }


  @override
  Widget build(BuildContext context) {
    var dutyProvider = Provider.of<DutyProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
        if (!didPop){
          final result = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Confirm Exit'),
                content: Text('Are you sure you want to exit? Any unsaved changes will be lost.'),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                       'No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent
                      ),
                    ),
                  ),
                ],
              )
          );

          if(result){
            Navigator.of(context).pop();
          }
        }

      },

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black87,
          title: Text(
            'Assign Duties',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(24),
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                  color: Colors.grey
                                )
                              ),
                              child: DropdownButton<String>(
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
                                isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                iconEnabledColor: Colors.black,
                                icon: Icon(Icons.arrow_drop_down),
                                hint: Text(
                                  'Name',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                elevation: 16,
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor: Colors.white,
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: DropdownButton<String>(
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

                            SizedBox(
                              height: 8,
                            ),

                            CustomTextField(
                              controller: owingController,
                              keyBoardType: TextInputType.number,
                              labelText: 'Owing (Optional)',
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Colors.grey,
                              )
                            )
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
                      margin: const EdgeInsets.all(24),
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
                    width: 16,
                  ),


                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(24),
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
                              btnColor: Colors.white,
                              width: 200,
                              borderRadius: 10,
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

                                  dutyProvider.addEmployeeToRoster(Helpers.addToRoster(selectedEmployee!, selectedDept!, selectedDutyOptions, int.parse(owingController!.text.isNotEmpty ? owingController!.text : '0')));

                                  selectedEmployee = null;
                                  selectedDept = null;

                                  if (owingController!.text.isNotEmpty){
                                    owingController!.clear();
                                  }

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
                              child: Text(
                                'Add to Rooster'
                              ),
                            ),

                            CustomButton(
                              btnColor: Colors.white,
                              width: 200,
                              borderRadius: 10,
                              onTap: () {
                                Helpers.temporaryNavigator(context, const TablePreviewScreen());
                              },
                              child: Text(
                                  'Add to Rooster'
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}