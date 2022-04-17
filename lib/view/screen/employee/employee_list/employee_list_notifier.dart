import 'package:employees_app/database/service/db_employee_service.dart';
import 'package:employees_app/database/service/db_leave_service.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/view/screen/employee/employee_detail/employee_detail_screen.dart';
import 'package:employees_app/view/screen/employee/employee_form/employee_form_page.dart';
import 'package:employees_app/view/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListNotifier extends ChangeNotifier {
  List<Employee> _listEmployee = [];

  List<Employee> get listEmployee => _listEmployee;

  String _filterValue = "All";

  String get filterValue => _filterValue;

  final List<String> _filterList = [
    "All",
    "Top 3 Employee",
    "Has Leave",
    "Has Leave More than 1"
  ];

  List<String> get filterList => _filterList;

  onInitScreen() async {
    _filterValue = "All";
    _listEmployee = await DBEmployeeService().selectEmployee();
    notifyListeners();
  }

  onClickEmployee(BuildContext context, Employee employee) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeDetailScreen(employee: employee)));
  }

  onClickAdd(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EmployeeFormPage()));
  }

  onChangeFilter(String value) async {
    _filterValue = value;
    _listEmployee = [];
    switch (_filterValue) {
      case "All":
        _listEmployee = await DBEmployeeService().selectEmployee();
        break;
      case "Top 3 Employee":
        _listEmployee = await DBEmployeeService().selectEmployeeTopThree();
        break;
      case "Has Leave":
        _listEmployee = await DBEmployeeService().selectEmployeeHasLeave();
        break;
      case "Has Leave More than 1":
        _listEmployee = await DBEmployeeService().selectEmployeeHasLeaveMoreThanOne();
        break;
    }
    notifyListeners();
  }

  onClickDelete(BuildContext context, Employee employee) async {
    int deleted = await DBEmployeeService().deleteEmployee(employee.numberId!);
    if (deleted > 0) {
      await DBLeaveService().deleteLeave(employee.numberId!);
      context.read<EmployeeListNotifier>().onInitScreen();
      SnackBarService.showSuccessSnackBar(context, "Employee has been deleted");
    }
  }

  onClickAddLeave(BuildContext context, Employee employee) async {
    Navigator.pop(context, employee);
  }
}
