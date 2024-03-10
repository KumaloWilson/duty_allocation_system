import 'package:flutter/material.dart';
import '../models/employee_model.dart';

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
}
