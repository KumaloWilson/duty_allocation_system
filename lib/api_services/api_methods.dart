import 'package:supabase_flutter/supabase_flutter.dart';

class ApiAssistants {

  static final supabase = Supabase.instance.client;

  static Future<dynamic> signUp(
      {String? username, String? dept, String? email, String? password}) async {
    try {
      final authResponse = await supabase.auth.signUp(
          email: email!,
          password: password!,
          data: {
            'username': username,
            'dept': dept,
          });

      return authResponse.user;

    } on AuthException catch (e) {
      print('Sign Up Error: $e');
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      // Your login logic goes here
    } on AuthException catch (e) {
      print('Login Error: $e');
    }
  }




  static Future<void> fetchEmployees(List<String> employeeNames) async {
    // Simulate dummy data
    final dummyEmployeeNames = [
      {
        'name': 'W Kumalo',
        'role': 'RGN',
      },
      {
        'name': 'T Ruzive',
        'role': 'RGN',
      },
      {
        'name': 'E Wemba',
        'role': 'RGN',
      },
      {
        'name': 'PW Chasakara',
        'role': 'RGN',
      },
      {
        'name': 'C Chinoruma',
        'role': 'Nurse Aid',
      },
      {
        'name': 'K Kasitiro',
        'role': 'Nurse Aid',
      },
      {
        'name': 'T Muchabaiwa',
        'role': 'General hand',
      },
      {
        'name': 'L Ndanda',
        'role': 'Red Cross',
      },
      {
        'name': 'W Chinula',
        'role': 'Red Cross',
      },
    ];

    for (int i = 0; i < dummyEmployeeNames.length; i++) {
      employeeNames.add(dummyEmployeeNames[i]['name']!);
    }
  }
}
