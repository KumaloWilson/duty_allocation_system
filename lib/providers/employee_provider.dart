// EmployeeProvider class (employee_provider.dart)
import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _allEmployees = [];

  List<Employee> _selectedEmployees = [];

  void addEmployeeToRoster(Employee employee) {
    _selectedEmployees.add(employee);
    _removeEmployeeFromDropdown(employee);
    notifyListeners();
  }

  List<Employee> get allEmployees => _allEmployees;

  List<Employee> get selectedEmployees => _selectedEmployees;

  void _removeEmployeeFromDropdown(Employee employee) {
    _allEmployees.removeWhere((e) => e.name == employee.name);
  }
}
