import 'package:employees_app/database/utils/value_utils.dart';
import 'package:employees_app/view/screen/employee/employee_list/employee_list_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  final String method;

  const EmployeeListScreen({Key? key, required this.method}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    context.read<EmployeeListNotifier>().onInitScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeListNotifier>(builder: (context, notifier, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Employee List"),
            actions: [
              InkWell(
                onTap: () {
                  notifier.onClickAdd(context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset("assets/add.png"),
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Filter",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Flexible(
                          child: DropdownButton<String>(
                            value: notifier.filterValue,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              notifier.onChangeFilter(value!);
                            },
                            items: notifier.filterList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: notifier.listEmployee.isNotEmpty
                    ? ListView.builder(
                        itemCount: notifier.listEmployee.length,
                        itemBuilder: (context, int index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  notifier.onClickEmployee(
                                      context, notifier.listEmployee[index]);
                                },
                                leading: Image.asset("assets/employee.png",
                                    height: 40),
                                title: Text(
                                  notifier.listEmployee[index].name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(notifier
                                              .listEmployee[index].numberId ??
                                          ""),
                                      Text(
                                          "Join Date: ${ValueUtils.generateDate(notifier.listEmployee[index].joinDate!)}"),
                                      const SizedBox(height: 4),
                                      notifier.listEmployee[index].leaveDate !=
                                              null
                                          ? Text(
                                              "Leave Date: ${ValueUtils.generateDate(notifier.listEmployee[index].leaveDate!)}")
                                          : Container(),
                                      notifier.listEmployee[index].note !=
                                          null
                                          ? Text(
                                          "Note: ${notifier.listEmployee[index].note!}")
                                          : Container()
                                    ],
                                  ),
                                ),
                                trailing: widget.method == "leave"
                                    ? InkWell(
                                        onTap: () {
                                          notifier.onClickAddLeave(context,
                                              notifier.listEmployee[index]);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(Icons.add),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          notifier.onClickDelete(context,
                                              notifier.listEmployee[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("assets/trash.png",
                                              height: 30),
                                        ),
                                      ),
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/division.png",
                                height: 80,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("There is no Employee yet"),
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ));
    });
  }
}
