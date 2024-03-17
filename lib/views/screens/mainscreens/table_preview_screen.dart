import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duty_allocation_system/utils/asset_utils/assets_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../helpers/helper_methods.dart';
import '../../../models/duty_model.dart';
import '../../../providers/duty_provider.dart';
import '../../../utils/colors/pallete.dart';
import '../../widgets/custom_button.dart';
class TablePreviewScreen extends StatefulWidget {
  const TablePreviewScreen({Key? key}) : super(key: key);

  @override
  State<TablePreviewScreen> createState() => _TablePreviewScreenState();
}

class _TablePreviewScreenState extends State<TablePreviewScreen> {
  late DutyProvider employeeDutyProvider;

  @override
  Widget build(BuildContext context) {
    employeeDutyProvider = Provider.of<DutyProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Pallete.primaryColor,
        title: const Text(
          'Preview Duties',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child:  ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Image.asset(
                        Assets.splashLogo,
                        height: 150,
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      DataTable(
                        border: TableBorder.all(
                          width: 2
                        ),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        columnSpacing: 20,
                        columns: const [
                          DataColumn(label: Text('NAME')),
                          DataColumn(label: Text('ROLE')),
                          DataColumn(label: Text('DEPT')),
                          DataColumn(label: Text('MONDAY')),
                          DataColumn(label: Text('TUESDAY')),
                          DataColumn(label: Text('WEDNESDAY')),
                          DataColumn(label: Text('THURSDAY')),
                          DataColumn(label: Text('FRIDAY')),
                          DataColumn(label: Text('SATURDAY')),
                          DataColumn(label: Text('SUNDAY')),
                          DataColumn(label: Text('OWING')),
                          DataColumn(label: Text('ACTION')), // Added column for delete button
                        ],
                        rows: _buildRows(employeeDutyProvider.selectedEmployees),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 32,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  width: 200,
                  btnColor: Pallete.primaryColor,
                  borderRadius: 10,
                  child: const Text(
                    'Save as PDF',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  onTap: () async{
                    String saveLocation = await Helpers.saveAsPDF(employeeDutyProvider.selectedEmployees, _buildTableData(employeeDutyProvider.selectedEmployees));

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'File Saved Successfully',
                            message: 'Location: $saveLocation',

                            contentType: ContentType.success,
                          ),
                        )
                    );
                  },
                ),

                const SizedBox(
                  width: 32,
                ),

                CustomButton(
                  width: 200,
                  btnColor: Pallete.primaryColor,
                  borderRadius: 10,
                  child: const Text(
                    'Save and Email PDF',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onTap: () {

                  },
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(List<DutyModel> employees) {
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
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteEmployee(employee);
              },
            ),
          ),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  void _deleteEmployee(DutyModel employee_duty) {
    setState(() {
      employeeDutyProvider.removeEmployeeFromRoster(employee_duty);
    });
  }

  List<List<String>> _buildTableData(List<DutyModel> employee_duties) {
    List<List<String>> tableData = [];

    for (var employee_duty in employee_duties) {
      tableData.add([
        employee_duty.name,
        employee_duty.role,
        employee_duty.department,
        employee_duty.monday,
        employee_duty.tuesday,
        employee_duty.wednesday,
        employee_duty.thursday,
        employee_duty.friday,
        employee_duty.saturday,
        employee_duty.sunday,
        employee_duty.owing.toString()
      ]);
    }

    return tableData;
  }
}
