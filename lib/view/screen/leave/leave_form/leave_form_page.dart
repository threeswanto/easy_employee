import 'package:employees_app/view/screen/leave/leave_form/leave_form_notifier.dart';
import 'package:employees_app/view/screen/leave/leave_form/leave_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveFormPage extends StatelessWidget {
  const LeaveFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LeaveFormNotifier(),
        child: const LeaveFormScreen());
  }
}
