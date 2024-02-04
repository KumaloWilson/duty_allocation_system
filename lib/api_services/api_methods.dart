class ApiAssistants {
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

    for (int i = 0; i <= dummyEmployeeNames.length; i++) {
      employeeNames.add(dummyEmployeeNames[i]['name']!);
    }
  }
}
