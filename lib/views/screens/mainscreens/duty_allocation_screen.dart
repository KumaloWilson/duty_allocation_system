import 'package:duty_allocation_system/api_services/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/employee_model.dart';
import '../../../providers/employee_provider.dart';
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

  List<String> dutyOptions = [
    "all day",
    "12.30hrs",
    "night duty",
    "LOCUM",
    "Nights off",
    "Vacation Leave",
    "Study Leave",
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
                  for (int i = 0; i < 7; i++)
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
                  TextField(
                    controller: notesController,
                    decoration: InputDecoration(labelText: 'Notes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Employee newEmployee = Employee(
                          name: selectedEmployee ?? '',
                          role: 'RGN',
                          department: 'pead',
                          monday: selectedDutyOptions[0],
                          tuesday: selectedDutyOptions[1],
                          wednesday: selectedDutyOptions[2],
                          thursday: selectedDutyOptions[3],
                          friday: selectedDutyOptions[4],
                          saturday: selectedDutyOptions[5],
                          sunday: selectedDutyOptions[6],
                          owing: 2);

                      employeeProvider.addEmployeeToRoster(newEmployee);

                      selectedEmployee = null;
                      selectedDutyOptions = List.filled(7, "all day");
                      notesController.clear();
                    },
                    child: Text('Add Employee to Roster'),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
