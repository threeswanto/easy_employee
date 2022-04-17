import 'package:employees_app/view/screen/menu/menu_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text("Easy Employee")),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Image.asset("assets/buildings.png", height: 100),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Easy Employee", style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            notifier.onClickMenu(context, "employee");
                          },
                          child: const Text("Employee List", style: TextStyle(color: Colors.white),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            notifier.onClickMenu(context, "leave");
                          },
                          child: const Text("Leave Form", style: TextStyle(color: Colors.black),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            notifier.onClickMenu(context, "exit");
                          },
                          child: const Text("Exit", style: TextStyle(color: Colors.white),)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
