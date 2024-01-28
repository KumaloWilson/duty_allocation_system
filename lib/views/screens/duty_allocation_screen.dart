import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/employee_model.dart';
import '../../providers/employee_provider.dart';
import 'table_preview_screen.dart';

class DutyAllocationScreen extends StatefulWidget {
  @override
  _DutyAllocationScreenState createState() => _DutyAllocationScreenState();
}

class _DutyAllocationScreenState extends State<DutyAllocationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Duty Allocation System'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: departmentController,
                    decoration: InputDecoration(labelText: 'Department'),
                  ),
                  TextField(
                    controller: roleController,
                    decoration: InputDecoration(labelText: 'Role'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          employeeProvider.addEmployee(
                              Employee(
                                name: nameController.text,
                                department: departmentController.text,
                                role: roleController.text,
                                monday: "monday",
                                tuesday: "tuesday",
                                wednesday: "wednesday",
                                thursday: "thursday",
                                friday: "friday",
                                saturday: "saturday",
                                sunday: "sunday",
                              )
                          );

                          nameController.clear();
                          departmentController.clear();
                          roleController.clear();
                        },
                        child: Text('Add Employee'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (c) => TablePreviewScreen()),
                          );
                        },
                        child: Text('Preview Duties'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
