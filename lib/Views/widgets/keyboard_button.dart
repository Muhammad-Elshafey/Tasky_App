import 'package:flutter/material.dart';

class KeyboardButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const KeyboardButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<KeyboardButton> createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          // side: BorderSide(
          //   color: Colors.grey.withValues(alpha: 0.4),
          //   width: 1.0,
          // ),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 34,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}