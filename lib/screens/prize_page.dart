import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../src/const.dart';
import '../widgets/button1.dart';
import '../widgets/color_checkbox.dart';

class PrizePage extends StatefulWidget {
  const PrizePage({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<PrizePage> createState() => _PrizePageState();
}

class _PrizePageState extends State<PrizePage> with TickerProviderStateMixin {
  String oldPrice = "50.00";
  String newPrice = "0.00";
  int selectedColor = 0;
  final Uri _url = Uri.parse('https://secure.cardcom.solutions/e/UN7l');
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: itemsPrize_1().length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
      body: SafeArea(
        child: Stack(
          children: [
            background(),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 700.h,
                      width: double.infinity,
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: itemsPrize_1())),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Cute Summer Baby Bucket Hat",
                          style: TextStyle(
                              fontSize: 65.sp, fontWeight: FontWeight.w700),
                        )),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "\$ $oldPrice",
                          style: const TextStyle(
                              decorationStyle: TextDecorationStyle.solid,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 35.w),
                        Text(
                          "\$ $newPrice",
                          style: TextStyle(
                              fontSize: 85.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0XFFFF007D)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 500.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Material: Cotton, Polyester",
                      style: TextStyle(
                          color: const Color(0XFF53625D),
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Size: 45 - 48 cm",
                      style: TextStyle(
                          color: const Color(0XFF53625D),
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Pick a color:",
                          style: TextStyle(
                              color: const Color(0XFF53625D),
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 30.w),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              selectedColor = 1;
                              tabController.animateTo(1);
                            });
                          }),
                          child: ColorCheckbox(
                            color: 0XFFF0EBEF,
                            isSelected: selectedColor == 1,
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              selectedColor = 2;
                              tabController.animateTo(2);
                            });
                          }),
                          child: ColorCheckbox(
                            color: 0XFFE0D1CF,
                            isSelected: selectedColor == 2,
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              selectedColor = 3;
                              tabController.animateTo(3);
                            });
                          }),
                          child: ColorCheckbox(
                            color: 0XFF8E6E59,
                            isSelected: selectedColor == 3,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Button1(
                      text: "Continue",
                      onPressed: _launchUrl,
                      enabled: selectedColor != 0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch try again';
  }
}

List<Widget> itemsPrize_1() {
  return [
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Image.asset(
          "assets/images/items/prize_1.png",
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
        ),
      ),
    ),
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Image.asset(
          "assets/images/items/prize_1_1.png",
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
        ),
      ),
    ),
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Image.asset(
          "assets/images/items/prize_1_2.png",
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
        ),
      ),
    ),
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Image.asset(
          "assets/images/items/prize_1_3.png",
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
        ),
      ),
    ),
  ];
}

Column background() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 40),
      Align(
          alignment: Alignment.topRight,
          child: Transform.rotate(
            angle: 10 * pi / 180,
            child: SvgPicture.asset(
              "assets/icons/Leaves.svg",
              height: 0.15.sh,
            ),
          )),
      const Spacer(),
      SizedBox(
        height: 300.h,
      ),
      Transform.rotate(
        angle: 120 * pi / 180,
        child: SvgPicture.asset(
          "assets/icons/upsidetree.svg",
          height: 0.15.sh,
        ),
      ),
      const Spacer(),
      Align(
          alignment: Alignment.topRight,
          child: Transform.rotate(
            angle: 10 * pi / 180,
            child: SvgPicture.asset(
              "assets/icons/Leaves.svg",
              height: 0.15.sh,
            ),
          )),
      const SizedBox(height: 40),
    ],
  );
}
