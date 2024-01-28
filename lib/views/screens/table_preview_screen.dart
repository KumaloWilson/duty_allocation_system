import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/employee_model.dart';
import '../../providers/employee_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
      body: Column(
        children: [
          DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Monday')),
              DataColumn(label: Text('Tuesday')),
              DataColumn(label: Text('Wednesday')),
              DataColumn(label: Text('Thursday')),
              DataColumn(label: Text('Friday')),
              DataColumn(label: Text('Saturday')),
              DataColumn(label: Text('Sunday')),
            ],
            rows: _buildRows(employeeProvider.employees),
          ),
          ElevatedButton(
            onPressed: () {
              saveAsPDF(employeeProvider.employees);
            },
            child: Text('Save as PDF'),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildRows(List<Employee> employees) {
    List<DataRow> rows = [];
    for (var employee in employees) {
      DataRow row = DataRow(
        cells: [
          DataCell(Text(employee.name)),
          DataCell(Text(employee.monday)),
          DataCell(Text(employee.tuesday)),
          DataCell(Text(employee.wednesday)),
          DataCell(Text(employee.thursday)),
          DataCell(Text(employee.friday)),
          DataCell(Text(employee.saturday)),
          DataCell(Text(employee.sunday)),
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
        employee.monday,
        employee.tuesday,
        employee.wednesday,
        employee.thursday,
        employee.friday,
        employee.saturday,
        employee.sunday,
      ]);
    }

    return tableData;
  }

  Future<void> saveAsPDF(List<Employee> employees) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: ['Name', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.center,
            cellHeight: 30,
            data: _buildTableData(employees),
          ),
        ],
      ),
    );

    final output = await getExternalStorageDirectory();
    print("External Storage Directory: ${output?.path}");
    final file = File("${output?.path}/duty_allocation.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
