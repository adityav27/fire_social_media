import 'package:flutter/material.dart';

class BioBox extends StatelessWidget {
  final String message;
  const BioBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding inside
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        // color
        color: Theme.of(context).colorScheme.secondary,
      ), // BoxDecoration
      child: Text(message.isNotEmpty ? message : "Empty bio.."),
    );
  }
}
