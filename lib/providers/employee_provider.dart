import 'package:flutter/material.dart';
import '../api_services/employee_methods/employee.dart';
import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {

  late Stream<List<EmployeeModel>> _employeesManagerStream;
  Stream<List<EmployeeModel>> get employeesManagerStream => _employeesManagerStream;

  EmployeeProvider() {
    _employeesManagerStream = _getEmployeesManagerStream();
  }

  Stream<List<EmployeeModel>> _getEmployeesManagerStream() {
    return EmployeeServices.getAllEmployeesManagerAsStream();
  }
}
