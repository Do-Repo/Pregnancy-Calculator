import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../src/const.dart';

class BabyCard extends StatefulWidget {
  const BabyCard({Key? key, required this.monthsleft}) : super(key: key);
  final int monthsleft;
  @override
  State<BabyCard> createState() => _BabyCardState();
}

class _BabyCardState extends State<BabyCard> {
  @override
  void initState() {
    super.initState();
  }

  String setImage(int monthsleft) {
    switch (monthsleft) {
      case 0:
      case 1:
        return "assets/icons/1month.svg";
      case 2:
        return "assets/icons/2month.svg";
      case 3:
        return "assets/icons/3month.svg";
      case 4:
        return "assets/icons/4month.svg";
      case 5:
        return "assets/icons/5month.svg";
      case 6:
        return "assets/icons/6month.svg";
      case 7:
        return "assets/icons/7month.svg";
      case 8:
        return "assets/icons/8month.svg";
      default:
        return "assets/icons/9month.svg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.monthsleft == 99)
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(25.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: const Color(0XFF68BAA5),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          color: const Color(0XFF60ab98),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.monthsleft == 0
                                      ? "Congratulations!"
                                      : "The Baby is now",
                                  style: secondcardbaby,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.monthsleft <= 0
                                      ? "Expect the baby to"
                                      : (9 - widget.monthsleft == 1)
                                          ? "${9 - widget.monthsleft} Month old"
                                          : "${9 - widget.monthsleft} Months old",
                                  style: secondcardcounter,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.monthsleft <= 0
                                      ? "arrive soon!"
                                      : (widget.monthsleft == 1)
                                          ? "${widget.monthsleft} Month left"
                                          : "${widget.monthsleft} Months left",
                                  style: secondcardcounter,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          setImage(9 - widget.monthsleft),
                          height: 0.13.sh,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
