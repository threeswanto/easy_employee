import 'package:date_time_picker/date_time_picker.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/view/screen/employee/employee_form/employee_form_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;

  const EmployeeFormScreen({Key? key, this.employee}) : super(key: key);

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  @override
  void initState() {
    context.read<EmployeeFormNotifier>().onInitForm(widget.employee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeFormNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Employee Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: notifier.formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ID",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text("${notifier.numberID}")
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                    controller: notifier.name,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    controller: notifier.address,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                DateTimePicker(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Birth Date cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  controller: notifier.controllerBirthDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Birth date',
                  onChanged: (value) => notifier.onChangeBirthDate(value),
                ),
                const SizedBox(height: 10),
                DateTimePicker(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Join Date cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  controller: notifier.controllerJoinDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Join Date',
                  onChanged: (value) => notifier.onChangeJoinDate(value),
                ),
                const SizedBox(
                  height: 50,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      notifier.onSavedEmployee(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
