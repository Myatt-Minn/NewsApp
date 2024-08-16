import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Function function;
  final double fontsize;
  const TabWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.function,
      required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
