import 'package:flutter/material.dart';
import '../api_services/employee_methods/employee.dart';
import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {

  late Stream<List<EmployeeModel>> _employeesManagerStream;
  Stream<List<EmployeeModel>> get employeesManagerStream => _employeesManagerStream;

  late Stream<List<EmployeeModel>> _employeesDutyStream;
  Stream<List<EmployeeModel>> get employeesDutyStream => _employeesDutyStream;


  EmployeeProvider() {
    _employeesManagerStream = _getEmployeesManagerStream();
    _employeesDutyStream = _getEmployeesDutyStream();
  }

  Stream<List<EmployeeModel>> _getEmployeesManagerStream() {
    return EmployeeServices.getAllEmployeesManagerAsStream();
  }

  Stream<List<EmployeeModel>> _getEmployeesDutyStream() {
    return EmployeeServices.getAllEmployeesDutyAsStream();
  }
}
