import 'package:flutter/material.dart';

class BuildDataLabel extends StatelessWidget {
  const BuildDataLabel({super.key, required this.label, required this.data});
  final String label;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '$label:',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        data,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
