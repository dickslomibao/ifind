import 'package:flutter/material.dart';

import '../../pallete.dart';

class MultiLineTextFieldBuildWidget extends StatelessWidget {
  const MultiLineTextFieldBuildWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
  });
  final String label;
  final String hint;
  final TextEditingController controller;
  final Function validator;

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
        Expanded(
          child: TextFormField(
            expands: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            validator: (value) {
              return validator(value);
            },
            textAlignVertical: TextAlignVertical.top,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
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
        ),
      ],
    );
  }
}
