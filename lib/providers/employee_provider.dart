import 'package:flutter/material.dart';
import '../api_services/employee_methods/employee.dart';
import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {
  List<EmployeeModel> _employees = [];
  List<EmployeeModel> get employees => _employees;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  Future<void> fetchEmployees({String dept = 'Wards'}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final employees = await EmployeeServices.getAllDeptEmployees(dept: dept);
      _employees = employees;

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _error = 'Failed to fetch employees: $error';
      _isLoading = false;
      notifyListeners();
    }
  }
}
