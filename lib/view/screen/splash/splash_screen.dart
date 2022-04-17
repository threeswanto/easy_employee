import 'dart:async';

import 'package:employees_app/view/screen/menu/menu_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    autoLogIn();
    super.initState();
  }

  void autoLogIn() async {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MenuPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Image.asset("assets/buildings.png", height: 80),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Easy Employee",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
