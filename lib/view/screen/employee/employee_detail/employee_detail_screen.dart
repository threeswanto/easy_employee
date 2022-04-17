import 'package:employees_app/database/utils/value_utils.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/view/screen/employee/employee_detail/employee_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeDetailScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  void initState() {
    context.read<EmployeeDetailNotifier>().onInitDetail(widget.employee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeDetailNotifier>(
      builder: (context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Detail Employee"),
          ),
          body: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Card(child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset("assets/employee.png", height: 50,),
                  )),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ID",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${notifier.employee?.numberId}"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${notifier.employee?.name}"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Birth Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(ValueUtils.generateDate(
                                notifier.employee!.birthDate!)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Join Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(ValueUtils.generateDate(
                                notifier.employee!.joinDate!)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${notifier.employee!.address}"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Leave Balance",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${notifier.leaveBalance}"),
                          ],
                        ),
                      ],),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    "Leave History",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: notifier.listLeave.isNotEmpty
                        ? ListView.builder(
                            itemCount: notifier.listLeave.length,
                            itemBuilder: (context, int index) {
                              return Card(
                                  child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(ValueUtils.generateDate(
                                          notifier.listLeave[index].leaveDate!)),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                          "${notifier.listLeave[index].leaveDays}"),
                                    ),
                                    SizedBox(
                                        width: 120,
                                        child: Text("${notifier.listLeave[index].note}")),
                                    InkWell(
                                      onTap: () {
                                        notifier.onClickDeleteLeave(
                                            context, notifier.listLeave[index]);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("assets/trash.png", height: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            })
                        : Column(
                            children: const [
                              Text("Employee has not leave yet"),
                            ],
                          ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        notifier.onClickEdit(context, notifier.employee!);
                      },
                      child: const Text(
                        "Edit Employee",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
