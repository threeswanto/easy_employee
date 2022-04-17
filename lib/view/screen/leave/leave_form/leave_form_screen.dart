import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'leave_form_notifier.dart';

class LeaveFormScreen extends StatefulWidget {
  const LeaveFormScreen({Key? key}) : super(key: key);

  @override
  State<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends State<LeaveFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveFormNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Leave Form"),
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
                      "Employee",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          notifier.onClickAddEmployee(context);
                        },
                        child: const Icon(Icons.add, color: Colors.white))
                  ],
                ),
                notifier.employee != null
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/employee.png", height: 30,),
                              Text("${notifier.employee?.name}", style: const TextStyle(fontWeight: FontWeight.bold),),
                              Text("${notifier.employee?.numberId}")
                            ],
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                DateTimePicker(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Start Date cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  controller: notifier.leaveDateStart,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Start Date',
                  onChanged: (value) => notifier.onChangeLeaveDateStart(value),
                ),
                const SizedBox(height: 10),
                DateTimePicker(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "End Date cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  controller: notifier.leaveDateEnd,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'End Date',
                  onChanged: (value) => notifier.onChangeLeaveDateEnd(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: notifier.leaveNote,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        labelText: 'Note',
                        hintText: 'Note',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Note cannot be empty";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      notifier.onSavedLeave(context);
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
