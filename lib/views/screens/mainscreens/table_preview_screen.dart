import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:duty_allocation_system/utils/asset_utils/assets_util.dart';
import '../../../helpers/helper_methods.dart';
import '../../../models/duty_model.dart';
import '../../../providers/duty_provider.dart';
import '../../../utils/colors/pallete.dart';
import '../../widgets/custom_button.dart';

class TablePreviewScreen extends StatefulWidget {
  final String to;
  final String from;
  const TablePreviewScreen({Key? key, required this.to, required this.from}) : super(key: key);

  @override
  State<TablePreviewScreen> createState() => _TablePreviewScreenState();
}

class _TablePreviewScreenState extends State<TablePreviewScreen> {
  late DutyProvider employeeDutyProvider;
  bool _isSorted = false;

  @override
  Widget build(BuildContext context) {
    employeeDutyProvider = Provider.of<DutyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Pallete.primaryColor,
        title: const Text(
          'Preview Duties',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.splashLogo,
                        height: 150,
                      ),
                      const SizedBox(height: 16),
                      DataTable(
                        border: TableBorder.all(width: 2),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Text('NAME')),
                          DataColumn(label: Text('ROLE')),
                          DataColumn(label: Text('DEPT')),
                          DataColumn(label: Text('MONDAY')),
                          DataColumn(label: Text('TUESDAY')),
                          DataColumn(label: Text('WEDNESDAY')),
                          DataColumn(label: Text('THURSDAY')),
                          DataColumn(label: Text('FRIDAY')),
                          DataColumn(label: Text('SATURDAY')),
                          DataColumn(label: Text('SUNDAY')),
                          DataColumn(label: Text('OWING')),
                          DataColumn(label: Text('ACTION')),
                        ],
                        rows: _isSorted
                            ? _buildSortedRows(employeeDutyProvider.selectedEmployees)
                            : _buildRows(employeeDutyProvider.selectedEmployees),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 200,
                  btnColor: Pallete.primaryColor,
                  borderRadius: 10,
                  child: const Text(
                    'Sort Table',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    setState(() {
                      _isSorted = true;
                      _buildSortedRows(employeeDutyProvider.selectedEmployees);
                    });
                  },
                ),
                const SizedBox(width: 32),
                CustomButton(
                  width: 200,
                  btnColor: Pallete.primaryColor,
                  borderRadius: 10,
                  child: const Text(
                    'Save as PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    String saveLocation = await Helpers.saveAsPDF(
                      employees:  employeeDutyProvider.selectedEmployees,
                      tableData:  _buildTableData(employeeDutyProvider.selectedEmployees),
                      fromDate: widget.from,
                      toDate: widget.to
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'File Saved Successfully',
                          message: 'Location: $saveLocation',
                          contentType: ContentType.success,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(List<DutyModel> employees) {
    List<DataRow> rows = [];
    for (var employee in employees) {
      DataRow row = DataRow(
        cells: [
          DataCell(
            TextFormField(
              initialValue: employee.name,
              onChanged: (newValue) {
                setState(() {
                  employee.name = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.role,
              onChanged: (newValue) {
                setState(() {
                  employee.role = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.department,
              onChanged: (newValue) {
                setState(() {
                  employee.department = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.monday,
              onChanged: (newValue) {
                setState(() {
                  employee.monday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.tuesday,
              onChanged: (newValue) {
                setState(() {
                  employee.tuesday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.wednesday,
              onChanged: (newValue) {
                setState(() {
                  employee.wednesday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.thursday,
              onChanged: (newValue) {
                setState(() {
                  employee.thursday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.friday,
              onChanged: (newValue) {
                setState(() {
                  employee.friday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.saturday,
              onChanged: (newValue) {
                setState(() {
                  employee.saturday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.sunday,
              onChanged: (newValue) {
                setState(() {
                  employee.sunday = newValue;
                });
              },
            ),
          ),

          DataCell(
            TextFormField(
              initialValue: employee.owing.toString(),
              onChanged: (newValue) {
                setState(() {
                  employee.owing = int.parse(newValue);
                });
              },
            ),
          ),

          DataCell(
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteEmployee(employee);
              },
            ),
          ),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  List<DataRow> _buildSortedRows(List<DutyModel> employees) {
    // Sort employees based on department and role
    employees.sort((a, b) {
      // Custom sorting logic
      final departmentComparison = _compareAndSortDepartments(a.department, b.department);
      if (departmentComparison == 0) {
        // If departments are the same, sort by role
        return _compareAndSortRoles(a.role, b.role);
      } else {
        // Otherwise, sort by department
        return departmentComparison;
      }
    });

    return _buildRows(employees);
  }

  int _compareAndSortDepartments(String departmentA, String departmentB) {
    // Define the order of departments
    final departmentOrder = ['Ward', 'OPD Peads', 'OPD Adults', 'TB Corner', ' '];

    // Compare departments based on their index in the order list
    return departmentOrder.indexOf(departmentA) - departmentOrder.indexOf(departmentB);
  }

  int _compareAndSortRoles(String roleA, String roleB) {
    // Define the order of roles
    final roleOrder = ['RGN', 'Nurse Aid', 'Gen Hand', 'General Hand', 'Student', ' '];

    // Compare roles based on their index in the order list
    return roleOrder.indexOf(roleA) - roleOrder.indexOf(roleB);
  }


  void _deleteEmployee(DutyModel employeeDuty) {
    setState(() {
      employeeDutyProvider.removeEmployeeFromRoster(employeeDuty);
    });
  }

  List<List<String>> _buildTableData(List<DutyModel> employeeDuties) {
    List<List<String>> tableData = [];

    for (var employeeDuty in employeeDuties) {
      tableData.add([
        employeeDuty.name,
        employeeDuty.role.toLowerCase() == 'student'
            ? 'RC Std'
            : employeeDuty.role.toLowerCase() == "general hand" ? 'Gen Hand' : employeeDuty.role,
        employeeDuty.department,
        employeeDuty.monday,
        employeeDuty.tuesday,
        employeeDuty.wednesday,
        employeeDuty.thursday,
        employeeDuty.friday,
        employeeDuty.saturday,
        employeeDuty.sunday,
        employeeDuty.owing.toString()
      ]);
    }

    return tableData;
  }
}
