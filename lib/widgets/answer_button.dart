import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_app/screens/result_page.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.id,
    required this.answer,
    required this.isCorrect,
  }) : super(key: key);

  final String answer;
  final int id;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(id: id, isCorrect: isCorrect)))),
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0XFFFA007C),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
            child: AutoSizeText(
              answer,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.roboto(
                fontSize: 19.5,
                fontWeight: FontWeight.w600,
                color: const Color(0XFFFFFFFF),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
