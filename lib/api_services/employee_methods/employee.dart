import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/models/employee_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EmployeeServices{
  static Future<void> addEmployee({required String firstName, required String lastName, required String role, required  String department}) async {
    // 1. Get a reference to the employees node in your database
    final databaseReference = FirebaseDatabase.instance.ref().child('employees');

    // 2. Create a new child node with a unique key
    final newEmployeeRef = databaseReference.push();

    // 3. Prepare employee data as a Map
    final employeeData = {
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'department': department,
      'createdAt': DateTime.now().toString(),
    };

    try {
      await newEmployeeRef.set(employeeData);
      print('Employee added successfully!');

    } catch (error) {
      print('Error adding employee: $error');
    }
  }


  static Future<List<EmployeeModel>> getAllDeptEmployees({required String dept}) async {
    final databaseReference = FirebaseDatabase.instance.ref().child('employees');
    final data = await databaseReference.orderByChild('department').equalTo(dept).once();

    final List<EmployeeModel> employees = [];

    if (data.snapshot.value != null) {
      // Iterate through each employee snapshot
      for (var childSnapshot in data.snapshot.children) {
        // Convert DataSnapshot to a Map
        final employeeData = Map<String, dynamic>.from(childSnapshot.value as Map);

        // Create EmployeeModel instance from the data
        final employee = EmployeeModel(
          firstName: employeeData['firstName'], // Corrected
          lastName: employeeData['lastName'],   // Corrected
          department: employeeData['department'],
          role: employeeData['role'],
        );

        // Add the employee to the list
        employees.add(employee);
      }
    }

    return employees;
  }

}