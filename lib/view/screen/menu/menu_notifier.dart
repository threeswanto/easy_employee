import 'package:employees_app/view/dialog/dialog_service.dart';
import 'package:employees_app/view/screen/employee/employee_list/employee_list_screen.dart';
import 'package:employees_app/view/screen/leave/leave_form/leave_form_page.dart';
import 'package:flutter/material.dart';

class MenuNotifier extends ChangeNotifier {
  void onClickMenu(BuildContext context, String menu) {
    switch (menu) {
      case "employee":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const EmployeeListScreen(method: "list")));
        break;
      case "leave":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LeaveFormPage()));
        break;
      case "exit":
        DialogService.onWillPop(context);
        break;
    }
  }
}
