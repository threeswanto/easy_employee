import 'dart:io';

import 'package:flutter/material.dart';

class DialogService {
  static Future onWillPop(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        title: const Text('Exit'),
        content: const Text('Are you sure want to Exit?'),
        actions: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: const StadiumBorder(),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
            ),
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
