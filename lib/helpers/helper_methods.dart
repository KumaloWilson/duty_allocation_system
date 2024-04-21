import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import '../models/duty_model.dart';

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
       context, MaterialPageRoute(builder: (c) => nextScreen)
    );
  }

  /// This methods capitalizes the first word of a [String]
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }


  static void back(BuildContext context){
    Navigator.pop(context);
  }


  //Method to add employees To the Roster
  static  addToRoster({required String selectedEmployee, required String selectedDept, required String employeeRole, required List selectedDutyOptions, required int? owing}){
    DutyModel newEmployee = DutyModel(
        name: selectedEmployee ?? '',
        role: employeeRole,
        department: selectedDept ?? '',
        monday: selectedDutyOptions[0],
        tuesday: selectedDutyOptions[1],
        wednesday: selectedDutyOptions[2],
        thursday: selectedDutyOptions[3],
        friday: selectedDutyOptions[4],
        saturday: selectedDutyOptions[5],
        sunday: selectedDutyOptions[6],
        owing: owing ?? 0
    );
    selectedDutyOptions = List.filled(7, "E");
    return newEmployee;
  }

  static Future<Uint8List> _loadLogoImage() async {
    final ByteData data = await rootBundle.load('assets/images/logo.png');
    return data.buffer.asUint8List();
  }

// Method to save table as PDF
  static Future<String> saveAsPDF({required List<DutyModel> employees, required var tableData, required String fromDate, required String toDate}) async {
    String? saveLocation;
    final pdf = pw.Document();
    final logoImage = await _loadLogoImage();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginLeft: 20.0,
          marginRight: 20.0,
          marginTop: 20.0,
          marginBottom: 20.0,
        ),
        header: (pw.Context context) {
          return pw.Column(
           children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Image(
                    pw.MemoryImage(logoImage),
                    width: 40,
                    height: 40,
                  )
                ]
            ),
             pw.SizedBox(
               height: 1
             ),
             pw.Row(
                 mainAxisAlignment: pw.MainAxisAlignment.center,
                 children: [
                   pw.Text(
                     'ST JOSEPH`S MISSION HOSPITAL DUTY',
                     style: pw.TextStyle(
                       fontWeight: pw.FontWeight.bold,
                       fontSize: 10
                     )
                   )
                 ]
             ),
            pw.SizedBox(height: 8),
             pw.Row(
                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                 children: [
                   pw.Text(
                     'FROM: $fromDate                                     .',
                     style: pw.TextStyle(
                       fontWeight: pw.FontWeight.bold,
                       decoration: pw.TextDecoration.underline,
                     ),
                   ),
                   pw.Text(
                     'TO: $toDate                                         .',
                     style: pw.TextStyle(
                       fontWeight: pw.FontWeight.bold,
                       decoration: pw.TextDecoration.underline,
                     ),
                   ),
                 ]
             ),
            pw.SizedBox(height: 12),
          ]);
        },
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: [
              'Name',
              'Role',
              'Dept',
              'Mon',
              'Tue',
              'Wed',
              'Thur',
              'Fri',
              'Sat',
              'Sun',
              'Owing'
            ],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            headerAlignment: pw.Alignment.center,
            cellAlignment: pw.Alignment.center,
            headerHeight: 20,
            cellHeight: 18,
            cellStyle: const pw.TextStyle(fontSize: 9),
            headerPadding: pw.EdgeInsets.zero,
            data: tableData,
          ),
        ],
      ),
    );

    // Let the user pick a directory to save the file
    final Directory? downloadsDir = await getDownloadsDirectory();
    if (downloadsDir != null) {
      final DateTime now = DateTime.now();
      final String formattedDate = '${now.year}-${now.month}-${now.day}';
      final String fileName = '$formattedDate duty_allocation.pdf';
      final filePath = path.join(downloadsDir.path, fileName);
      final File file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      saveLocation = filePath;

    }

    return saveLocation!;
  }


}
