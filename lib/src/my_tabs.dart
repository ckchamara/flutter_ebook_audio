import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppTabs extends StatelessWidget {
  final String text;
  final Color color;

  const AppTabs({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 7,
                  offset: const Offset(0, 0)),
            ]),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
  }
}
