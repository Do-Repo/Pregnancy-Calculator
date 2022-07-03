import 'package:flutter/material.dart';

class ColorCheckbox extends StatelessWidget {
  const ColorCheckbox({Key? key, required this.color, required this.isSelected})
      : super(key: key);
  final int color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        width: 25,
        height: 25,
        child: Container(
          decoration: BoxDecoration(
              color: Color(color),
              border: Border.all(
                  style: (isSelected) ? BorderStyle.solid : BorderStyle.none,
                  width: 2,
                  color: const Color(0XFFFA007C))),
        ),
      ),
    );
  }
}
