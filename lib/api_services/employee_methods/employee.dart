import 'package:duty_allocation_system/models/employee_model.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../utils/random/randomizer.dart';

class EmployeeServices{
  static Future<void> addEmployee({required String firstName, required String lastName, required String role, required String department}) async {
    final databaseReference = FirebaseDatabase.instance.ref().child('employees');
    final employeeData = {
      'employee_id': RandomHelpers.generateRandomId(),
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'department': department,
      'createdAt': DateTime.now().toString(),
    };

    try {
      await databaseReference.push().set(employeeData);
      // await OfflineEmployeeCache.cacheEmployees([employeeData]);
      print('Employee added successfully!');
    } catch (error) {
      print('Error adding employee: $error');
      print('Employee data cached for later retry: $employeeData'); // Log cached employee data
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
          employeeId: employeeData['employee_id'],
          firstName: employeeData['firstName'],
          lastName: employeeData['lastName'],
          department: employeeData['department'],
          role: employeeData['role'],
        );

        employees.add(employee);
      }
    }

    return employees;
  }

  static Future<void> deleteEmployee(String employeeId) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref().child('employees');
      final employeeRef = databaseReference.child(employeeId);
      final employeeData = await employeeRef.once();

      if (employeeData.snapshot.value != null) {
        await employeeRef.remove();
        print('Employee deleted successfully!');
      } else {
        throw Exception('Employee with ID $employeeId does not exist.');
      }
    } catch (error) {
      print('Error deleting employee: $error');
    }
  }
}