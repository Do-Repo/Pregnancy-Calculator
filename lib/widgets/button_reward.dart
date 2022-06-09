import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/lessonlist_page.dart';

class RewardButton extends StatelessWidget {
  const RewardButton({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LessonList(name: name)))),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFFE54291),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/reward.svg',
                width: .06.sw,
              ),
              SizedBox(width: .02.sw),
              Text('Get Present',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
