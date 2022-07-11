import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pregnancy_app/services/ads_services.dart';
import 'package:provider/provider.dart';

import '../screens/lessonlist_page.dart';

class RewardButton extends StatefulWidget {
  const RewardButton({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<RewardButton> createState() => _RewardButtonState();
}

class _RewardButtonState extends State<RewardButton> {
  bool isAdLoaded = false;
  late InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    interstitialAd = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    InterstitialAd.load(
        adUnitId: adState.interstitialPresent,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            isAdLoaded = true;
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print(error.toString() + ' button_reward ad');
          },
        ));
  }

  @override
  void dispose() {
    if (interstitialAd != null) interstitialAd!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => {
            print(isAdLoaded),
            if (isAdLoaded && interstitialAd != null)
              {
                interstitialAd!.show().then((value) => Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => LessonList(name: widget.name))))
              }
            else
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LessonList(name: widget.name)))
              }
          }),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFFE54291),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/reward.svg',
                width: .06.sw,
              ),
              SizedBox(width: .02.sw),
              Text('Get Present',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
