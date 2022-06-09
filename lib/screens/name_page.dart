import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pregnancy_app/services/shared_prefs.dart';
import 'package:pregnancy_app/widgets/button1.dart';

import 'date_page.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  bool enableBtn = false;
  String input = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          decoration: const BoxDecoration(
              color: Color(0XFF68BAA5),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background.jpg"),
              )),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: .2.sh),
                  Container(
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/maintree.svg',
                          height: 1.sh * 0.055,
                        ),
                        Center(
                          child: Text(
                            'Welcome To',
                            style: GoogleFonts.poppins(
                              fontSize: 70.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0XFF68BAA5),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Pregnancy Tracker',
                            style: GoogleFonts.poppins(
                              fontSize: 70.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0XFF68BAA5),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.03.sh),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Center(
                            child: TextField(
                              onChanged: (value) {
                                input = value;
                                setState(() {
                                  if (value.length > 2 && value.length < 20) {
                                    enableBtn = true;
                                  } else {
                                    enableBtn = false;
                                  }
                                });
                              },
                              style: GoogleFonts.poppins(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your name',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          height: 0.065.sh,
                          decoration: BoxDecoration(
                            color: const Color(0XFFF3F3F3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Button1(
                          text: "Start",
                          enabled: enableBtn,
                          onPressed: () async {
                            await SharedPrefServices().setName(input).then(
                                (value) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DatePage(name: input))));
                          },
                        ),
                        SizedBox(height: 0.03.sh),
                      ],
                    ),
                  ),
                ],
              ),
              IgnorePointer(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset(
                    "assets/icons/woman.svg",
                    height: .5.sh,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
