import 'package:flutter/material.dart';

class MyLogobutton extends StatelessWidget {
  final VoidCallback? whatToDo;
  final String message;
  final String? logoLocation;
  final Color? textColor;
  final Color? bgColor;
  const MyLogobutton({
    super.key,
    this.whatToDo,
    required this.message,
    this.logoLocation,
    this.textColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (whatToDo != null) whatToDo!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logoLocation != null && logoLocation!.isNotEmpty) ...[
            Image.asset(logoLocation!, width: 30),
            SizedBox(width: 20),
          ],

          Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
