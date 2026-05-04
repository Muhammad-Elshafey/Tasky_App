import 'package:flutter/material.dart';
import 'package:projects/core/theme/theme_controller.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    this.textColor,
    required this.title,
  });

  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final String? Function(String?)? validator;
  final String title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: textColor == null
              ? Theme.of(context).textTheme.labelMedium
              : TextStyle(color: textColor),
          validator: validator,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
