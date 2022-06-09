import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_app/models/quiz.dart';
import 'package:pregnancy_app/services/shared_prefs.dart';

import '../src/const.dart';
import '../widgets/answer_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String name = '';
  List<String> options = [];
  String question = "";
  int correctAnswer = 0;

  @override
  void initState() {
    super.initState();
    SharedPrefServices().getName().then((prefValue) {
      getQuestions().then((quizValue) {
        setState(() {
          name = prefValue.toUpperCase();
          options = quizValue.options;
          correctAnswer = quizValue.correct;
          question = quizValue.question;
        });
      });
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Leave",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("You haven't answered yet!"),
      content: const Text(
          "You're about to leave but you haven't answered yet, are you sure you want to leave?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> makeButtons() {
    List<Widget> list = [];
    for (var element in options) {
      list.add(AnswerButton(
        id: widget.id,
        answer: element,
        isCorrect:
            (options.indexOf(element) == correctAnswer - 1) ? true : false,
      ));
    }
    return list;
  }

  Future<Quiz> getQuestions() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/quiz.json');
    List jsonResult = json.decode(data);
    return Quiz.fromJson(jsonResult[widget.id - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showAlertDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0XFFFA007C), size: 30),
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0XFF60AB97),
          leading: IconButton(
              onPressed: (() => showAlertDialog(context)),
              icon: const Icon(Icons.arrow_back_ios)),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "$name'S  PREGNANCY APP",
              style: appBarTitle,
            ),
          ),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
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
                  SizedBox(height: 0.04.sh),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(question,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        )),
                  ),
                  ...makeButtons(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                          angle: -60 * pi / 180,
                          child: SvgPicture.asset(
                            "assets/icons/tree.svg",
                            height: 0.14.sh,
                          )),
                      SvgPicture.asset("assets/icons/Leaves.svg",
                          height: 0.14.sh)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
