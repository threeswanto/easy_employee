import 'package:employees_app/view/screen/menu/menu_notifier.dart';
import 'package:employees_app/view/screen/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuNotifier(), child: const MenuScreen());
  }
}
