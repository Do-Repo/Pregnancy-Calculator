import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pregnancy_app/screens/name_page.dart';
import 'package:pregnancy_app/services/notification_services.dart';

import 'package:pregnancy_app/src/const.dart';

import '../models/quotes.dart';
import '../services/shared_prefs.dart';
import '../widgets/baby_card.dart';
import '../widgets/button_reward.dart';
import '../widgets/day_counter.dart';
import '../widgets/quote_card.dart';
import '../widgets/top_card.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String name = "", quote = "", author = "";
  int monthsleft = 99;
  int daysleft = 99;
  @override
  void initState() {
    super.initState();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    SharedPrefServices().getDate().then((value) {
      final DateTime date = formatter.parse(value);
      final DateTime today = DateTime.now();
      final difference = today.difference(date);
      final days = difference.inDays;
      final months = difference.inDays ~/ 30;

      // final weeks = difference.inDays ~/ 7;
      // final years = difference.inDays ~/ 365;
      SharedPrefServices().getName().then((n) {
        NotificationService().setNotification(3, "Hey ${n.capitalize()}!",
            "Review the quote of the day!", 10, 0, "--", context);
        SharedPrefServices().getQuoteIndex().then((qi) {
          SharedPrefServices().getUpdateDate().then((ud) {
            getQuote(context, ud, qi).then((q) {
              listenNotifications();
              setState(() {
                quote = q.quote;
                author = q.author;
                monthsleft = months * -1;
                name = n.toUpperCase();
                daysleft = days * -1;
              });
            });
          });
        });
      });
    });
  }

  void onClickNotification(String payload) async {
    if (payload.isNotEmpty) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: notificationDialog(context, quote, author),
            );
          });
    }
  }

  void listenNotifications() async {
    var ns = NotificationService();
    ns.notificationSubject.stream.listen((event) {
      onClickNotification(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/tree.svg",
                      fit: BoxFit.fitHeight,
                    ),
                    RewardButton(name: name)
                  ],
                ),
                const SizedBox(height: 5),
                TopCard(
                  name: name,
                  text:
                      "Have an amazing day, and don't forget to take good care of yourself and your little one!",
                ),
                const SizedBox(height: 10),
                BabyCard(
                  monthsleft: monthsleft,
                ),
                QuoteCard(
                  quote: quote,
                  author: author,
                ),
                Row(
                  children: [
                    const Spacer(),
                    SvgPicture.asset("assets/icons/upsidetree.svg")
                  ],
                ),
                DayCounter(daysLeft: daysleft),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: ListTile(
                      onTap: (() => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NamePage()))),
                      title: Text(
                        "Change dates and show calendar again",
                        style: buttoncard,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_down)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Quotes> getQuote(
    BuildContext context, String updateDate, int quoteIndex) async {
  var pref = SharedPrefServices();
  String data = await DefaultAssetBundle.of(context)
      .loadString('assets/json/quotes.json');
  var jsonResult = json.decode(data);
  int randomIndex = Random().nextInt(jsonResult.length);

  if (updateDate.isEmpty || quoteIndex == 0) {
    // In case no date is set or the index is 0, set the date to today
    pref.setUpdateDate(setTiming(10, 0).toString());
    pref.setQuoteIndex(randomIndex);
    return Quotes(
      jsonResult[randomIndex]['quote'],
      jsonResult[randomIndex]['author'],
      jsonResult[randomIndex]['id'],
    );
  } else if (DateTime.parse(updateDate)
          .difference(DateTime.now().subtract(DateTime.now().timeZoneOffset))
          .inHours
          .abs() >
      24) {
    // In case the date is more than 24 hours old, set the date to today
    pref.setUpdateDate(setTiming(10, 0).toString());
    pref.setQuoteIndex(randomIndex);
    return Quotes(
      jsonResult[randomIndex]['quote'],
      jsonResult[randomIndex]['author'],
      jsonResult[randomIndex]['id'],
    );
  } else {
    // In case the date is less than 24 hours old, show today's quote
    return Quotes(
      jsonResult[quoteIndex]['quote'],
      jsonResult[quoteIndex]['author'],
      jsonResult[quoteIndex]['id'],
    );
  }
}

Widget notificationDialog(BuildContext context, String quote, String author) {
  //  Color(0XFF68BAA5),
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFFC6FCEC)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Color(0XFF68BAA5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    height: 45.sp,
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/notification.svg',
                      height: 75.sp,
                      color: Colors.white,
                    ),
                    DefaultTextStyle(
                        style: notification,
                        child: const Text("Daily Inspiration")),
                  ],
                ),
                const Spacer(),
                const SizedBox()
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                  style: thirdcardone,
                  textAlign: TextAlign.center,
                  child: Text("“$quote”")),
              const SizedBox(height: 10),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DefaultTextStyle(
                      style: thirdcardone, child: Text("- $author"))),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    ),
  );
}
