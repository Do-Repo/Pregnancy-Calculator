import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pregnancy_app/widgets/button1.dart';

import '../screens/home_page.dart';
import '../src/const.dart';
import 'package:intl/intl.dart';

class Sheet extends StatelessWidget {
  const Sheet(
      {Key? key,
      required this.weeksPassed,
      required this.daysPassed,
      required this.weeksLeft,
      required this.firstDate,
      required this.lastDate})
      : super(key: key);
  final double weeksPassed;
  final double daysPassed;
  final double weeksLeft;
  final String firstDate;
  final String lastDate;
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM dd ,yyyy');
    return Container(
      padding: EdgeInsets.only(
        top: .06.sh,
        left: .08.sw,
        right: .08.sw,
        bottom: .03.sh,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "BASED ON MENSTRUAL PERIOD DATE",
            style: bottomsheettitle,
          ),
          Text(
            weeksPassed.toStringAsFixed(0).length == 1
                ? weeksPassed.toString().substring(0, 1) +
                    ' WEEKS  ' +
                    daysPassed.toStringAsFixed(0) +
                    '  DAYS PASSED'
                : weeksPassed.toString().substring(0, 2) +
                    ' WEEKS  ' +
                    daysPassed.toStringAsFixed(0) +
                    '  DAYS PASSED',
            style: bottomsheetsubtitle,
          ),
          Text(
            weeksLeft.toStringAsFixed(0) + ' WEEKS LEFT ',
            style: bottomsheetsubtitle,
          ),
          SizedBox(height: .03.sh),
          Text(
            'ESTIMATED BIRTHDATE (38W - 40W)',
            style: bottomsheettitle,
          ),
          Text(
            '${formatter.format(
              DateTime.parse(firstDate.substring(0, 10)),
            )}  -  ${formatter.format(
              DateTime.parse(lastDate.substring(0, 10)),
            )}',
            style: bottomsheetsubtitle,
          ),
          SizedBox(
            height: .03.sh,
          ),
          Button1(
            text: "Confirm",
            onPressed: () {
              // Breaks out of bottom sheet
              Navigator.of(context).pop();
              // Breaks out of name page
              Navigator.of(context).pop();
              // Breaks and pushes to home page
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Homepage()));
            },
            enabled: true,
          )
        ],
      ),
    );
  }
}
