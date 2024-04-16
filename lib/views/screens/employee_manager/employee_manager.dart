import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/utils/colors/pallete.dart';
import 'package:duty_allocation_system/views/screens/employee_manager/add_employee.dart';
import 'package:duty_allocation_system/views/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:duty_allocation_system/providers/employee_provider.dart';

import '../../../models/employee_model.dart';

class EmployeeManager extends StatefulWidget {
  const EmployeeManager({Key? key}) : super(key: key);

  @override
  State<EmployeeManager> createState() => _EmployeeManagerState();
}

class _EmployeeManagerState extends State<EmployeeManager> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Manage Employees',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: ()=>Helpers.temporaryNavigator(context, const AddEmployee()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<EmployeeModel>>(
          stream: Provider.of<EmployeeProvider>(context).employeesManagerStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final employees = snapshot.data ?? [];
              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return EmployeeCard(employee: employee);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
