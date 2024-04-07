import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../api_services/employee_methods/employee.dart';
import '../models/employee_model.dart';

class EmployeeProvider with ChangeNotifier {
  final BehaviorSubject<List<EmployeeModel>> _employeesSubject = BehaviorSubject<List<EmployeeModel>>();
  Stream<List<EmployeeModel>> get employeesStream => _employeesSubject.stream;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  EmployeeProvider() {
    fetchEmployees();
  }

  Future<void> fetchEmployees({String dept = 'ward'}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final employees = await EmployeeServices.getAllDeptEmployees(dept: dept);
      _employeesSubject.add(employees);

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _error = 'Failed to fetch employees: $error';
      _isLoading = false;
      notifyListeners();
    }
  }

  void dispose() {
    _employeesSubject.close(); // Close the subject when no longer needed
    super.dispose();
  }
}
