import 'package:employees_app/model/employee.dart';
import 'package:employees_app/view/screen/employee/employee_form/employee_form_screen.dart';
import 'package:employees_app/view/screen/employee/employee_form/employee_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeFormPage extends StatelessWidget {
  final Employee? employee;
  const EmployeeFormPage({Key? key, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EmployeeFormNotifier(),
        child: EmployeeFormScreen(employee: employee));
  }
}
