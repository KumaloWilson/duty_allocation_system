import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/helper_methods.dart';
import '../../../models/employee_model.dart';
import '../../../providers/employee_provider.dart';

class TablePreviewScreen extends StatefulWidget {
  const TablePreviewScreen({Key? key}) : super(key: key);

  @override
  State<TablePreviewScreen> createState() => _TablePreviewScreenState();
}

class _TablePreviewScreenState extends State<TablePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    var employeeProvider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Dept')),
                DataColumn(label: Text('Monday')),
                DataColumn(label: Text('Tuesday')),
                DataColumn(label: Text('Wednesday')),
                DataColumn(label: Text('Thursday')),
                DataColumn(label: Text('Friday')),
                DataColumn(label: Text('Saturday')),
                DataColumn(label: Text('Sunday')),
                DataColumn(label: Text('Owing')),
              ],
              rows: _buildRows(employeeProvider.selectedEmployees),
            ),
            ElevatedButton(
              onPressed: () {
                Helpers.saveAsPDF(employeeProvider.selectedEmployees,
                    _buildTableData(employeeProvider.selectedEmployees));
              },
              child: Text('Save as PDF'),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(List<Employee> employees) {
    List<DataRow> rows = [];
    for (var employee in employees) {
      DataRow row = DataRow(
        cells: [
          DataCell(Text(employee.name)),
          DataCell(Text(employee.role)),
          DataCell(Text(employee.department)),
          DataCell(Text(employee.monday)),
          DataCell(Text(employee.tuesday)),
          DataCell(Text(employee.wednesday)),
          DataCell(Text(employee.thursday)),
          DataCell(Text(employee.friday)),
          DataCell(Text(employee.saturday)),
          DataCell(Text(employee.sunday)),
          DataCell(Text(employee.owing.toString())),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  List<List<String>> _buildTableData(List<Employee> employees) {
    List<List<String>> tableData = [];

    for (var employee in employees) {
      tableData.add([
        employee.name,
        employee.role,
        employee.department,
        employee.monday,
        employee.tuesday,
        employee.wednesday,
        employee.thursday,
        employee.friday,
        employee.saturday,
        employee.sunday,
        employee.owing.toString()
      ]);
    }

    return tableData;
  }
}
