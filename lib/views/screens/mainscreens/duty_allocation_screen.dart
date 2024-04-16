import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/models/employee_model.dart';
import 'package:duty_allocation_system/utils/colors/pallete.dart';
import 'package:duty_allocation_system/views/widgets/custom_button.dart';
import 'package:duty_allocation_system/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/duty_provider.dart';
import '../../../providers/employee_provider.dart';
import '../../../utils/asset_utils/assets_util.dart';
import 'table_preview_screen.dart';

class DutyAllocationScreen extends StatefulWidget {
  const DutyAllocationScreen({super.key});

  @override
  _DutyAllocationScreenState createState() => _DutyAllocationScreenState();
}

class _DutyAllocationScreenState extends State<DutyAllocationScreen> {
  TextEditingController? owingController = TextEditingController();
  String? selectedEmployeeName;
  String? selectedDept;
  String? selectedEmployeeRole;

  List<String> dutyOptions = [
    " ",
    "E",
    "12:30",
    "7-7",
    "PM",
    "AM",
    "N.D",
    "D.O",
    "N.0",
    "Sick Leave",
    "Vac Leave",
    "Ann Leave",
    "Sty Leave",
  ];

  List<String> deptOptions = [
    " ",
    "OPD Peads",
    "OPD Adults",
    "Wards",
    "TB Corner"
  ];

  List<String> selectedDutyOptions = List.filled(7, "E");

  List<EmployeeModel> availableEmployees = [];

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() {
    Provider.of<EmployeeProvider>(context, listen: false).employeesDutyStream.listen((List<EmployeeModel> employees) {
      setState(() {
        availableEmployees = employees;
      });
    }, onError: (error) {
      // Handle error if needed
      print('Error fetching employees: $error');
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
                title: const Text('Confirm Exit'),
                content: const Text('Are you sure you want to exit? Any unsaved changes will be lost.'),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
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
                    child: const Text(
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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Pallete.primaryColor,
          title: const Text(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  Assets.splashLogo,
                  height: 150,
                ),

                const SizedBox(
                  height: 16,
                ),


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
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                    color: Colors.grey
                                  )
                                ),
                                child: DropdownButton<String>(
                                  value: selectedEmployeeName,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedEmployeeName = newValue!;
                                    });
                                  },
            
                                    //employees.map((employee) => "${employee.firstName[0]}. ${employee.lastName}").toList();
            
                                  items: availableEmployees.map((EmployeeModel employee) {
                                    return DropdownMenuItem<String>(
                                      value: "${employee.firstName[0]}. ${employee.lastName}",
                                      child: Text(
                                          "${employee.firstName[0]}. ${employee.lastName}"
                                      ),
                                      onTap: (){
                                        selectedEmployeeRole = employee.role;
                                      },
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  iconEnabledColor: Colors.black,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text(
                                    'Name',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  elevation: 16,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Colors.white,
                                ),
                              ),
            
                              const SizedBox(
                                height: 8,
                              ),
            
            
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  underline: const SizedBox(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  iconEnabledColor: Colors.black,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: const Text(
                                    'Dept',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  elevation: 16,
                                  borderRadius: BorderRadius.circular(10),
                                  dropdownColor: Colors.white,
                                ),
                              ),
            
                              const SizedBox(
                                height: 8,
                              ),
            
                              CustomTextField(
                                controller: owingController,
                                keyBoardType: TextInputType.number,
                                labelText: 'Owing (Optional)',
                                prefixIcon: const Icon(
                                  Icons.numbers,
                                  color: Colors.grey,
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            
                    const SizedBox(
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
                                          child: Text(
                                            dutyOption,
                                            style: const TextStyle(
                                              fontSize: 12
                                            ),
                                          ),
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
            
            
                    const SizedBox(
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
            
                              const SizedBox(
                                height: 12,
                              ),
            
                              CustomButton(
                                btnColor: Colors.green,
                                width: 200,
                                borderRadius: 10,
                                onTap: () {
            
                                  if (selectedEmployeeName == '' || selectedEmployeeName == null){
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
            
                                    dutyProvider.addEmployeeToRoster(
                                        Helpers.addToRoster(
                                           selectedEmployee: selectedEmployeeName!,
                                           employeeRole: selectedEmployeeRole!,
                                           selectedDept:  selectedDept!,
                                           selectedDutyOptions:  selectedDutyOptions,
                                           owing: int.parse(owingController!.text.isNotEmpty ? owingController!.text : '0')
                                        )
                                    );
            
                                    selectedEmployeeName = null;
                                    selectedDept = null;
                                    selectedDutyOptions = List.filled(7, "E");


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
                                child: const Text(
                                  'Add to Rooster',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
            
                              const SizedBox(
                                height: 12,
                              ),
            
                              CustomButton(
                                btnColor: Pallete.primaryColor,
                                width: 200,
                                borderRadius: 10,
                                onTap: () {
                                  Helpers.temporaryNavigator(context, const TablePreviewScreen());
                                },
                                child: const Text(
                                  'Preview Duty',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
            
                              const SizedBox(
                                height: 12,
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
      ),
    );
  }
}