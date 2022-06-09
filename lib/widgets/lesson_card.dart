import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_app/src/const.dart';

import '../screens/lesson_page.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.state,
  }) : super(key: key);

  final int id, state;
  final String title, content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (state != -1)
          ? (() => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LessonPage(
                    id: id,
                    title: title,
                    content: content,
                    state: state,
                  ))))
          : null,
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
          color: (state == 1)
              ? const Color(0XFF60AB97)
              : (state == 0)
                  ? const Color(0XFFFA007C)
                  : const Color(0XFF989C9B),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15),
            Icon(
              (state == 1)
                  ? Icons.check_circle
                  : (state == 0)
                      ? Icons.circle_outlined
                      : Icons.lock,
              color: Colors.white,
              size: 30,
            ),
            const Spacer(),
            Text("Lesson   $id", style: lesonsCard),
            const Spacer(),
            Container(
              width: 5.sp,
              height: 190.h,
              color: Colors.white,
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
