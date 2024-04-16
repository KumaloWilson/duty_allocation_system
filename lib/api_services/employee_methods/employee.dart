import 'package:duty_allocation_system/models/employee_model.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../utils/random/randomizer.dart';

class EmployeeServices {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Function to enable offline persistence (consider using a separate class)
  static Future<void> enableOfflinePersistence() async {
    try {
      _database.setPersistenceEnabled(true);
      print('Offline persistence enabled successfully!');
    } catch (error) {
      print('Error enabling offline persistence: $error');
    }
  }

  static Future<void> addEmployee({
    required String firstName,
    required String lastName,
    required String role,
    required String department,
  }) async {
    final databaseReference = _database.ref().child('employees');
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
      print('Employee added successfully!');
    } catch (error) {
      print('Error adding employee: $error');
      // Implement offline caching logic here (e.g., using a local storage solution)
      // ...
    }
  }

  // static Future<List<EmployeeModel>> getAllDeptEmployees({
  //   required String dept,
  // }) async {
  //   final databaseReference = _database.ref().child('employees');
  //   final data = await databaseReference.orderByChild('department').equalTo(dept).once();
  //
  //   final List<EmployeeModel> employees = [];
  //
  //   if (data.snapshot.value != null) {
  //     // Iterate through each employee snapshot
  //     for (var childSnapshot in data.snapshot.children) {
  //       // Convert DataSnapshot to a Map
  //       final employeeData = Map<String, dynamic>.from(childSnapshot.value as Map);
  //
  //       // Create EmployeeModel instance from the data
  //       final employee = EmployeeModel(
  //         employeeId: employeeData['employee_id'],
  //         firstName: employeeData['firstName'],
  //         lastName: employeeData['lastName'],
  //         department: employeeData['department'],
  //         role: employeeData['role'],
  //       );
  //
  //       employees.add(employee);
  //     }
  //   }
  //
  //   return employees;
  // }

  static Future<void> deleteEmployee(String employeeId) async {
    try {
      // Construct a query to find employees by employeeId
      final query = _database.ref().child('employees').orderByChild('employee_id').equalTo(employeeId);

      // Get a DataSnapshot containing matching employees
      final dataSnapshots = await query.once();

      if (dataSnapshots.snapshot.value == null || dataSnapshots.snapshot.value.toString().isEmpty) {
        print('Employee with ID $employeeId not found.');
        return;
      }

      // Loop through matching employees and delete them
      for (DataSnapshot snapshot in dataSnapshots.snapshot.children) {
        await snapshot.ref.remove();
      }

      print('Employee(s) with ID $employeeId deleted successfully!');
    } catch (error) {
      print('Error deleting employee: $error');
    }
  }


  static Stream<List<EmployeeModel>> getAllEmployeesManagerAsStream() {
    final databaseReference = _database.ref().child('employees');
    return databaseReference.onValue.map((event) {
      final List<EmployeeModel> employees = [];
      if (event.snapshot.value != null) {
        for (var childSnapshot in event.snapshot.children) {
          final employeeData = Map<String, dynamic>.from(childSnapshot.value as Map);
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
    });
  }

  static Stream<List<EmployeeModel>> getAllEmployeesDutyAsStream() {
    final databaseReference = _database.ref().child('employees');
    return databaseReference.onValue.map((event) {
      final List<EmployeeModel> employees = [];
      if (event.snapshot.value != null) {
        for (var childSnapshot in event.snapshot.children) {
          final employeeData = Map<String, dynamic>.from(childSnapshot.value as Map);
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
    });
  }

}
