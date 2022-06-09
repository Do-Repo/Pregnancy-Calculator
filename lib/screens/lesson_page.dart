import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';

import '../services/shared_prefs.dart';
import '../src/const.dart';
import '../widgets/complete_button.dart';
import 'lessonlist_page.dart';

class LessonPage extends StatefulWidget {
  const LessonPage(
      {Key? key,
      required this.id,
      required this.title,
      required this.content,
      required this.state})
      : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
  final int id, state;
  final String title, content;
}

class _LessonPageState extends State<LessonPage> {
  String name = '';

  @override
  void initState() {
    super.initState();

    SharedPrefServices().getName().then((value) {
      setState(() {
        name = value.toUpperCase();
      });
    });
  }

  void navigateBack() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => LessonList(
                name: name,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateBack();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0XFFFA007C), size: 30),
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0XFF60AB97),
          leading: IconButton(
              onPressed: (() => navigateBack()),
              icon: const Icon(Icons.arrow_back_ios)),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "$name'S  PREGNANCY APP",
              style: appBarTitle,
            ),
          ),
        ),
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text("Lesson ${widget.id}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 68.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0XFFFA007C),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Text(widget.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0XFFFA007C),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -20 * pi / 180,
                      child: SvgPicture.asset(
                        'assets/icons/upsidetree.svg',
                        height: 0.14.sh,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StyledText(
                    text: widget.content,
                    tags: {
                      'bold': StyledTextTag(
                        style: GoogleFonts.poppins(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    },
                    style: GoogleFonts.poppins(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Spacer(),
                Transform.rotate(
                  angle: -35 * pi / 180,
                  child: SvgPicture.asset(
                    'assets/icons/tree.svg',
                    height: 0.12.sh,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Complete(
                      state: widget.state,
                      id: widget.id,
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
