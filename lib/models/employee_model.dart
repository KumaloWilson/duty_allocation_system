class Employee {
  String name;
  String department;
  String role;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  Employee({
    required this.name,
    required this.department,
    required this.role,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  Map<String, String> toMap() {
    return {
      'Name': name,
      'Mon': monday,
      'Tue': tuesday,
      'Wed': wednesday,
      'Thu': thursday,
      'Fri': friday,
      'Sat': saturday,
      'Sun': sunday,
    };
  }
}
