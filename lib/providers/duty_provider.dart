import 'package:flutter/material.dart';
import '../models/duty_model.dart';

class DutyProvider extends ChangeNotifier {
  final List<DutyModel> _allEmployees = [];
  final List<DutyModel> _selectedEmployees = [];

  void addEmployeeToRoster(DutyModel employee) {
    _selectedEmployees.add(employee);
    _removeEmployeeFromDropdown(employee);
    notifyListeners();
  }

  void removeEmployeeFromRoster(DutyModel employee) {
    _selectedEmployees.remove(employee);
    _addEmployeeToDropdown(employee);
    notifyListeners();
  }

  List<DutyModel> get allEmployees => _allEmployees;

  List<DutyModel> get selectedEmployees => _selectedEmployees;

  void _removeEmployeeFromDropdown(DutyModel employee) {
    _allEmployees.removeWhere((e) => e.name == employee.name);
  }

  void _addEmployeeToDropdown(DutyModel employee) {
    _allEmployees.add(employee);
  }

  void updateEmployeeDuty(DutyModel employee) {
    // Find the index of the employee in the list
    int index = _selectedEmployees.indexOf(employee);

    if (index != -1) {
      // Update the employee data in the list
      _selectedEmployees[index] = employee;
      // Notify listeners about the change
      notifyListeners();
    }
  }
}

