import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? whatToDo;
  final String text;
  const MyButton({super.key, required this.whatToDo, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whatToDo,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
