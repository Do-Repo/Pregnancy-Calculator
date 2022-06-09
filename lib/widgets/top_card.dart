import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../src/const.dart';

class TopCard extends StatelessWidget {
  const TopCard({Key? key, required this.name, required this.text})
      : super(key: key);

  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {
    return (name.isEmpty)
        ? Container()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Wrap(
                        children: [
                          Text("  Hey ", style: heyname),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("${name.capitalize()} 😍",
                                  style: heyname)),
                        ],
                      ),
                      Text(text, style: topcardtext),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                SvgPicture.asset("assets/icons/WomenVector.svg",
                    height: 0.12.sh),
              ],
            ),
          );
  }
}
