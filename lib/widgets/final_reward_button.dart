import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_app/screens/roulette_page.dart';

import '../src/const.dart';

class FinalRewardButton extends StatelessWidget {
  const FinalRewardButton({Key? key, required this.states, required this.name})
      : super(key: key);

  final List<String> states;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (states.length - 1 == 10) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Roulette(name: name)));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0XFFF3A0C9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15),
            SvgPicture.asset(
              'assets/icons/reward.svg',
              height: 50,
              fit: BoxFit.fitWidth,
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Get Your", style: lesonsCard),
                Text("Free Present!", style: lesonsCard),
              ],
            ),
            const Spacer(),
            Container(
              width: 5.sp,
              height: 250.h,
              color: Colors.white,
            ),
            const Spacer(),
            SizedBox(
              width: 50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "${states.length - 1} / 10",
                      style: lesonsCard,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("Completed",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFFFFFFFF),
                        )),
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
