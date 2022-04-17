import 'package:employees_app/view/screen/employee/employee_detail/employee_detail_notifier.dart';
import 'package:employees_app/view/screen/employee/employee_list/employee_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => EmployeeListNotifier()),
      ChangeNotifierProvider(create: (_) => EmployeeDetailNotifier())
    ], child: const MyApp()),
  );
}
