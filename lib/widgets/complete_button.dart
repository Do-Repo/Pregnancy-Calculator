import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/quiz_page.dart';

class Complete extends StatefulWidget {
  const Complete({Key? key, required this.state, required this.id})
      : super(key: key);

  final int state, id;

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.state == 1) {
          // Notify that it's already done
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizPage(
                        id: widget.id,
                      )));
        }
      },
      child: Container(
        width: 1.sw,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            color: const Color(0XFF60AB97)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15),
            Flexible(
              fit: FlexFit.tight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  (widget.state == 1)
                      ? "Completed"
                      : "Take a Quiz To Complete The Lesson!",
                  style: GoogleFonts.poppins(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFFFFFFFF),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Container(
              width: 5.sp,
              height: 150.h,
              color: Colors.white,
            ),
            const SizedBox(width: 15),
            Icon(
              (widget.state == 1) ? Icons.check_circle : Icons.circle_outlined,
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
