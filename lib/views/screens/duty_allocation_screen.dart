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
  TextEditingController notesController = TextEditingController();
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
    _fetchEmployees();
  }

  List<String> _employeeNames = [];

  Future<void> _fetchEmployees() async {
    // Simulate dummy data
    final List<String> dummyEmployeeNames = ['John Doe', 'Jane Smith', 'Alice Johnson'];

    setState(() {
      _employeeNames.addAll(dummyEmployeeNames);
    });

  }

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
                    items: _employeeNames.map((String employeeName) {
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
                        monday: selectedDutyOptions[0],
                        tuesday: selectedDutyOptions[1],
                        wednesday: selectedDutyOptions[2],
                        thursday: selectedDutyOptions[3],
                        friday: selectedDutyOptions[4],
                        saturday: selectedDutyOptions[5],
                        sunday: selectedDutyOptions[6],
                        department: notesController.text,
                        role: selectedEmployee ?? '',
                      );

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
