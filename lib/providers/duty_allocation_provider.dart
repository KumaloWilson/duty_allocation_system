import 'package:flutter/material.dart';
import '../api_services/employee_methods/employee.dart';
import '../models/employee_model.dart';

class DutyAllocationProvider with ChangeNotifier {

  late Stream<List<EmployeeModel>> _employeesDutyStream;
  Stream<List<EmployeeModel>> get employeesDutyStream => _employeesDutyStream;


  DutyAllocationProvider() {
    _employeesDutyStream = _getEmployeesDutyStream();
  }

  Stream<List<EmployeeModel>> _getEmployeesDutyStream() {
    return EmployeeServices.getAllEmployeesDutyAsStream();
  }
}
