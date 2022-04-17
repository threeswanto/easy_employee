import 'package:employees_app/database/service/db_leave_service.dart';
import 'package:employees_app/database/utils/value_utils.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/model/leave.dart';
import 'package:employees_app/view/screen/employee/employee_list/employee_list_screen.dart';
import 'package:employees_app/view/snackbar/snackbar_service.dart';
import 'package:flutter/material.dart';

class LeaveFormNotifier extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Employee? _employee;

  Employee? get employee => _employee;

  final TextEditingController _leaveDateStart = TextEditingController();

  TextEditingController get leaveDateStart => _leaveDateStart;

  final TextEditingController _leaveDateEnd = TextEditingController();

  TextEditingController get leaveDateEnd => _leaveDateEnd;

  final TextEditingController _leaveNote = TextEditingController();

  TextEditingController get leaveNote => _leaveNote;

  onClickAddEmployee(BuildContext context) async {
    Employee? employeeTemp = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmployeeListScreen(method: "leave")));
    if (employeeTemp != null) {
      _employee = employeeTemp;
      notifyListeners();
    }
  }

  onChangeLeaveDateStart(String value) {
    _leaveDateStart.text = value;
    notifyListeners();
  }

  onChangeLeaveDateEnd(String value) {
    _leaveDateEnd.text = value;
    notifyListeners();
  }

  onSavedLeave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if(_employee != null) {
        Leave leave = Leave();
        leave.numberId = _employee!.numberId;
        leave.leaveDate = _leaveDateStart.text;
        leave.leaveDays = ValueUtils.generateDaysLeave(
            _leaveDateStart.text, _leaveDateEnd.text);
        leave.note = _leaveNote.text;
        int saved = await DBLeaveService().insertLeave(leave);
        if (saved > 0) {
          Navigator.pop(context);
          SnackBarService.showSuccessSnackBar(
              context, "Leave ${_employee?.name} is saved");
        } else {
          SnackBarService.showWarningSnackBar(
              context, "Employee ${_employee?.name} is not saved");
        }
      } else {
        SnackBarService.showWarningSnackBar(
            context, "Employee not selected");
      }
    }
  }
}
