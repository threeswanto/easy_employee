import 'package:employees_app/database/service/db_employee_service.dart';
import 'package:employees_app/database/service/db_leave_service.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/model/leave.dart';
import 'package:employees_app/view/screen/employee/employee_form/employee_form_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDetailNotifier extends ChangeNotifier {
  Employee? _employee;

  Employee? get employee => _employee;

  List<Leave> _listLeave = [];

  List<Leave> get listLeave => _listLeave;

  int? _leaveBalance;

  int? get leaveBalance => _leaveBalance;

  onInitDetail(Employee employee) async {
    _leaveBalance = 12;
    int countLeave = 0;
    _employee = await DBEmployeeService().selectEmployeeByID(employee);
    _listLeave = await DBLeaveService().selectLeaveByEmployee(employee);
    for (var element in _listLeave) {
      countLeave += element.leaveDays!;
    }
    _leaveBalance = _leaveBalance! - countLeave;
    notifyListeners();
  }

  onClickEdit(BuildContext context, Employee employee) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmployeeFormPage(employee: employee)));
  }

  onClickDeleteLeave(BuildContext context, Leave leave) async {
    int deleted = await DBLeaveService().deleteLeave(leave.numberId!);
    if(deleted > 0) {
      context.read<EmployeeDetailNotifier>().onInitDetail(_employee!);
    }
  }
}
