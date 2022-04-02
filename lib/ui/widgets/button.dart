import 'package:flutter/material.dart';
import 'package:my_todo_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final Function() onTab;

  MyButton({required this.lable, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryClr
          ),
          width: 100,
          height: 45,
          child: Center(
            child: Text(
              lable,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        onTap: onTab,
      ),
    );
  }
}
