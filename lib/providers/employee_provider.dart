import 'package:flutter/material.dart';

import '../models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }
}