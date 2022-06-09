import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Button1 extends StatefulWidget {
  const Button1(
      {Key? key, required this.text, this.enabled, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool? enabled;
  @override
  State<Button1> createState() => _Button1State();
}

class _Button1State extends State<Button1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (widget.enabled == true) ? widget.onPressed : null,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Center(
          child: Text(
            widget.text,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        height: 0.065.sh,
        decoration: BoxDecoration(
          color: (widget.enabled == null || widget.enabled!)
              ? const Color(0XFFFF007D)
              : const Color.fromARGB(76, 255, 0, 123),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
