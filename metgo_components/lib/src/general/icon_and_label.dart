import 'package:flutter/material.dart';

class MIconAndLabel extends StatelessWidget {
  final IconData? icon;
  final String? label;
  const MIconAndLabel({super.key, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon ?? Icons.error_outline_outlined,
                size: 15,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80),
            )),
        Text(label ?? "")
      ],
    );
  }
}
