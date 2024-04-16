import 'package:duty_allocation_system/api_services/employee_methods/employee.dart';
import 'package:duty_allocation_system/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/asset_utils/assets_util.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) async{
        await EmployeeServices.deleteEmployee(employee.employeeId);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
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

}