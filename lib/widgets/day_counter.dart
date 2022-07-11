import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pregnancy_app/src/const.dart';

class DayCounter extends StatelessWidget {
  const DayCounter({Key? key, required this.daysLeft}) : super(key: key);
  final int daysLeft;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      padding: const EdgeInsets.all(10),
      width: 1.sw,
      decoration: BoxDecoration(
        color: const Color(0XFF68BAA5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              (daysLeft == 1)
                  ? "$daysLeft Day left to birth date"
                  : (daysLeft < 0)
                      ? (daysLeft == -1)
                          ? "The baby is 1 day old"
                          : "The baby is ${daysLeft.abs()} days old"
                      : (daysLeft == 0)
                          ? "Expect the baby to arrive soon!"
                          : "$daysLeft Days left to birth date",
              style: fourthcard,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset("assets/icons/babycard.svg",
                fit: BoxFit.fitHeight),
          ],
        ),
      ),
    );
  }
}
