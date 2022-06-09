import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pregnancy_app/services/shared_prefs.dart';
import 'package:pregnancy_app/widgets/button1.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../src/const.dart';
import '../widgets/date_confirm_sheet.dart';
import '../widgets/top_card.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key, this.name}) : super(key: key);
  final String? name;
  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String date = "";
  double weeks = 0;
  String firstDate = '';
  double days = 0;
  double weekspassed = 0;
  double dayspassed = 0;
  double weeksleft = 0;
  String lastDate = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset("assets/icons/tree.svg"),
          ),
          TopCard(
            name: widget.name ?? "There",
            text: "Please select the last menstrual period",
          ),
          const SizedBox(height: 30),
          datePicker(),
          const SizedBox(height: 30),
          dateCard(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Button1(
              text: "Calculate",
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    context: context,
                    builder: (context) => Sheet(
                          weeksPassed: weekspassed,
                          weeksLeft: weeksleft,
                          daysPassed: dayspassed,
                          firstDate: firstDate,
                          lastDate: lastDate,
                        ));
              },
              enabled: (date.isEmpty) ? false : true,
            ),
          )
        ],
      ))),
    );
  }

  void countWeeks() {
    setState(() {
      weeks = DateTime.parse(date)
              .add(const Duration(days: 280))
              .difference(DateTime.parse(date))
              .inDays /
          7;
      days = DateTime.parse(date)
              .add(const Duration(days: 280))
              .difference(DateTime.parse(date))
              .inDays /
          7 %
          7;
      weekspassed = DateTime.now().difference(DateTime.parse(date)).inDays / 7;
      dayspassed = DateTime.now().difference(DateTime.parse(date)).inDays *
          1 %
          7.toDouble();
      weeksleft = 40 - weekspassed;
    });
  }

  void countBirthdate() {
    setState(() {
      firstDate =
          DateTime.parse(date).add(const Duration(days: 266)).toString();
      lastDate = DateTime.parse(date).add(const Duration(days: 280)).toString();
      SharedPrefServices().setDate(lastDate);
    });
  }

  Container dateCard() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(-1, 0), // changes position of shadow
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOUR DATE',
                    style: dateTextColor,
                  ),
                  const SizedBox(height: 5),
                  Text(
                      date.isEmpty
                          ? 'Choose a date please'
                          : date.substring(0, 10),
                      style: yourdateTextColor),
                ],
              ),
            ),
          ],
        ));
  }

  Widget datePicker() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SfDateRangePicker(
          selectionColor: const Color(0XFFFF007D),
          headerStyle:
              const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
          selectionMode: DateRangePickerSelectionMode.single,
          showNavigationArrow: true,
          navigationMode: DateRangePickerNavigationMode.snap,
          allowViewNavigation: true,
          view: DateRangePickerView.month,
          minDate: DateTime(
              DateTime.now().year, DateTime.now().month - 8, 1, 0, 0, 0),
          maxDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            SharedPrefServices().setDate(args.value.toString());
            setState(() {
              date = args.value.toString();
              countWeeks();
              countBirthdate();
            });
          },
        ),
      ),
    );
  }
}
