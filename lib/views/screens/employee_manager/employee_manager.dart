import 'package:duty_allocation_system/utils/colors/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:duty_allocation_system/api_services/employee_methods/employee.dart';
import 'package:duty_allocation_system/providers/employee_provider.dart';
import 'package:duty_allocation_system/utils/asset_utils/assets_util.dart';
import 'package:duty_allocation_system/views/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/loading_widgets/custom_loader.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class EmployeeManager extends StatefulWidget {
  const EmployeeManager({Key? key}) : super(key: key);

  @override
  State<EmployeeManager> createState() => _EmployeeManagerState();
}

class _EmployeeManagerState extends State<EmployeeManager> {
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
    "Wards",
    "Maternity",
    "Laboratory",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Manage Employees', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _showAddEmployeeDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<EmployeeProvider>(
          builder: (context, employeeProvider, _) {
            if (employeeProvider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              final employees = employeeProvider.employees;
              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Image.asset(
                        _getImageAsset(employee.role),
                      ),
                      title: Text(
                        '${employee.lastName} ${employee.firstName}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(employee.role),
                      trailing: Text(employee.department),
                    ),
                  );
                },
              );
            }
          },
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

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                Assets.addEmployeesAnimation,
                width: 100,
              ),
              Text(
                'Add Employee',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                  labelText: 'First Name',
                  controller: _firstNameController,
                  prefixIcon: Icon(Icons.person)),
              SizedBox(height: 16),
              CustomTextField(
                  labelText: 'Last Name',
                  controller: _lastNameController,
                  prefixIcon: Icon(Icons.person)),


              SizedBox(
                height: 16,
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
                    'Dept',
                    style: TextStyle(color: Colors.grey),
                  ),
                  elevation: 16,
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.white,
                ),
              ),


              SizedBox(
                height: 16,
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
                  items: employeeDept.map((String dept) {
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
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: _addEmployee,
            child: Text('Add'),
          ),
        ],
      ),
    );
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

      Navigator.of(context).pop();
      Navigator.of(context).pop();

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

  @override
  void initState() {
    super.initState();
    Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
  }
}
