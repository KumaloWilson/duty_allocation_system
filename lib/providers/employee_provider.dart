// EmployeeProvider class (employee_provider.dart)
import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _allEmployees = [
    Employee(name: "John Doe", department: "IT", role: "Developer", monday: 'monday', tuesday: 'tuesday', wednesday: 'wednesday', thursday: 'thursday', friday: 'friday', saturday: 'saturday', sunday: 'sunday'),
    Employee(name: "Jane Smith", department: "HR", role: "Manager" , monday: 'monday', tuesday: 'tuesday', wednesday: 'wednesday', thursday: 'thursday', friday: 'friday', saturday: 'saturday', sunday: 'sunday'),
    // Add more employees as needed
  ];

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