import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pregnancy_app/screens/lessonlist_page.dart';
import 'package:pregnancy_app/services/shared_prefs.dart';
import 'package:provider/provider.dart';

import '../services/ads_services.dart';
import '../src/const.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.id, required this.isCorrect})
      : super(key: key);
  final bool isCorrect;
  final int id;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String name = "";
  int count = 0;
  List<String> lessons = [];
  bool isAdLoaded = false;
  late InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    interstitialAd = null;
    SharedPrefServices().getName().then((prefValue) {
      if (widget.isCorrect) {
        SharedPrefServices().getLessons().then((list) {
          lessons = list;
          lessons.add(widget.id.toString());
          SharedPrefServices().setLessons(lessons);
        });
      }
      setState(() {
        name = prefValue.toUpperCase();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    InterstitialAd.load(
        adUnitId: adState.interstitialQuiz,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            isAdLoaded = true;
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print(error.toString() + ' result page ad');
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0XFFFA007C), size: 30),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => goBack(widget.isCorrect),
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: const Color(0XFF60AB97),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "$name'S  PREGNANCY APP",
            style: appBarTitle,
          ),
        ),
      ),
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Column(
            children: [
              Text("QUIZ",
                  style: TextStyle(
                    fontFamily: "Arial Rounded MT Bold",
                    fontSize: 105.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 20.sp,
                    color: const Color(0XFFFA007C),
                  )),
              Text("Lesson ${widget.id}",
                  style: GoogleFonts.poppins(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFFFA007C),
                  )),
              const Spacer(),
              Text((widget.isCorrect) ? "Correct Answer!" : "Wrong Answer!",
                  style: GoogleFonts.poppins(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFFFA007C),
                  )),
              Text(
                  (widget.isCorrect)
                      ? "You Completed Lesson ${widget.id} / 10!"
                      : "Try Again!",
                  style: GoogleFonts.poppins(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFFFA007C),
                  )),
              SizedBox(height: 100.h),
              GestureDetector(
                onTap: () => goBack(widget.isCorrect),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0XFFFA007C),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 15, bottom: 15),
                    child: FittedBox(
                      child: Text(
                        (widget.isCorrect)
                            ? "Back To Lessons"
                            : "Back To Lesson",
                        style: GoogleFonts.roboto(
                          fontSize: 19.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        )
      ]),
    );
  }

  void goBack(bool isCorrect) {
    if (isAdLoaded && interstitialAd != null) {
      interstitialAd!.show().then((value) => {
            (isCorrect)
                ? {
                    Navigator.popUntil(context, (route) => route.isFirst),
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LessonList(name: name)))
                  }
                : {Navigator.of(context).pop()}
          });
    } else {
      (isCorrect)
          ? {
              Navigator.popUntil(context, (route) => route.isFirst),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LessonList(name: name)))
            }
          : {Navigator.of(context).pop()};
    }
  }
}
