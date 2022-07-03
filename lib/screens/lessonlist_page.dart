import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/lessons.dart';
import '../services/shared_prefs.dart';
import '../src/const.dart';
import '../src/widget_animator.dart';
import '../widgets/lesson_card.dart';
import '../widgets/final_reward_button.dart';

class LessonList extends StatefulWidget {
  const LessonList({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  List<Lessons> lessons = [];
  List<String> states = [];
  @override
  void initState() {
    super.initState();
    getLessons().then((lesson) {
      SharedPrefServices().getLessons().then((state) {
        setState(() {
          states = state;
          lessons = lesson;
        });
      });
    });
  }

  int getState(int id) {
    if (states.contains(id.toString())) {
      //Lesson Completed
      return 1;
    } else if (states.last.contains((id - 1).toString())) {
      //Lesson unlocked
      return 0;
    } else {
      //Lesson locked
      return -1;
    }
  }

  List<Widget> buttonList(List<Lessons> lessons) {
    List<Widget> list = [];
    for (var lesson in lessons) {
      list.add(WidgetAnimator(
        child: LessonCard(
          id: lesson.id,
          title: lesson.title,
          content: lesson.content,
          state: getState(lesson.id),
        ),
      ));
    }
    return list;
  }

  Future<List<Lessons>> getLessons() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/lessons.json');
    List jsonResult = json.decode(data);

    return jsonResult.map((data) => Lessons.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0XFFFA007C), size: 30),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0XFF60AB97),
        leading: IconButton(
            onPressed: (() => Navigator.of(context).pop()),
            icon: const Icon(Icons.arrow_back_ios)),
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "${widget.name}'S  PREGNANCY APP",
            style: appBarTitle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.rotate(
                    angle: -20 * pi / 180,
                    child: SvgPicture.asset(
                      'assets/icons/upsidetree.svg',
                      height: 0.12.sh,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          Text("Lessons", style: lesonss),
                          SizedBox(height: ScreenUtil().setHeight(10)),
                          RichText(
                            text: TextSpan(
                              text:
                                  "Complete 10 lessons that will help you take care of your little one and get a ",
                              style: lesonsStart,
                              children: [
                                TextSpan(
                                  text: "FREE",
                                  style: lesons,
                                ),
                                TextSpan(
                                  text: " present!",
                                  style: lesonsStart,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(240)),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Column(children: [
                ...buttonList(lessons),
                FinalRewardButton(
                  states: states,
                  name: widget.name,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
