import 'package:flutter/material.dart';

import '../../pallete.dart';

class TextFieldBuildWidget extends StatelessWidget {
  const TextFieldBuildWidget(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.validator,
      required this.icon,
      this.onTap});
  final String label;
  final String hint;
  final TextEditingController controller;
  final Function validator;
  final IconData icon;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: label == "" ? 10 : 15,
        ),
        Visibility(
          visible: label != "",
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: txtColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          validator: (value) {
            return validator(value);
          },
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, .4),
            ),
          ),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
