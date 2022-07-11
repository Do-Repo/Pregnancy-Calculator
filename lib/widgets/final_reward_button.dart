import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pregnancy_app/screens/roulette_page.dart';
import 'package:pregnancy_app/services/ads_services.dart';
import 'package:provider/provider.dart';

import '../src/const.dart';

class FinalRewardButton extends StatefulWidget {
  const FinalRewardButton({Key? key, required this.states, required this.name})
      : super(key: key);

  final List<String> states;
  final String name;

  @override
  State<FinalRewardButton> createState() => _FinalRewardButtonState();
}

class _FinalRewardButtonState extends State<FinalRewardButton> {
  late RewardedAd? rewardedAd;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    rewardedAd = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    RewardedAd.load(
        adUnitId: adState.rewardedAd,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            loaded = true;
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            loaded = false;
          },
        ));
  }

  @override
  void dispose() {
    if (rewardedAd != null) rewardedAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.states.length - 1 == 10) {
          if (rewardedAd != null && loaded) {
            rewardedAd!.show(
                onUserEarnedReward: ((ad, reward) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Roulette(name: widget.name)))
                    }));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Roulette(name: widget.name)));
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: (widget.states.length - 1 == 10)
                ? const Color(0XFFFF007D)
                : const Color(0XFFF3A0C9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 15),
            SvgPicture.asset(
              'assets/icons/reward.svg',
              height: 50,
              fit: BoxFit.fitWidth,
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Get Your", style: lesonsCard),
                Text("Free Present!", style: lesonsCard),
              ],
            ),
            const Spacer(),
            Container(
              width: 5.sp,
              height: 250.h,
              color: Colors.white,
            ),
            const Spacer(),
            SizedBox(
              width: 50,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "${widget.states.length - 1} / 10",
                      style: lesonsCard,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text("Completed",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFFFFFFFF),
                        )),
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
