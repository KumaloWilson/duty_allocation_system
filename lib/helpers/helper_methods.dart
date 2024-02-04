import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import '../models/employee_model.dart';

class Helpers {
  // Method to navigate to another screen with back function
  /// This function navigates to another screen and also allows the user to go back to the previous screen
  static void temporaryNavigator(BuildContext context, Widget nextScreen) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => nextScreen));
  }

  // Method to navigate to another screen without back function
  /// This function completely deletes the previous screen from the context hence the back key completely exits the app
  static void permanentNavigator(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (c) => nextScreen));
  }

  // Method to save table as PDF
  static Future<void> saveAsPDF(List<Employee> employees, var tableData) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 20.0,
          marginRight: 20.0,
          marginTop: 20.0,
          marginBottom: 20.0,
        ),
        header: (pw.Context context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'FROM:...............................................................',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'TO:.................................................................',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ]),
            pw.SizedBox(height: 12),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Compiled By:.......................................................',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Date:..............................................................',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ]),
            pw.SizedBox(height: 12),
          ]);
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
              'Comment:...................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          );
        },
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: [
              'Name',
              'Role',
              'Dept',
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday',
              'Sunday',
              'Owing'
            ],
            headerStyle:
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headerHeight: 40,
            cellHeight: 30,
            cellStyle: pw.TextStyle(fontSize: 10),
            headerPadding: pw.EdgeInsets.zero,
            data: tableData,
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
