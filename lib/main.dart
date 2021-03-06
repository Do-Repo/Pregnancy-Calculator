import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:pregnancy_app/screens/home_page.dart';
import 'package:pregnancy_app/services/ads_services.dart';
import 'package:pregnancy_app/services/notification_services.dart';
import 'package:pregnancy_app/services/shared_prefs.dart';

import 'screens/name_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  bool ft = await isFirstTime();
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(
      firstTime: ft,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.firstTime}) : super(key: key);
  final bool firstTime;
  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> isFirstTime() async {
  bool firstTime = true;
  await SharedPrefServices().getName().then((name) async {
    await SharedPrefServices().getDate().then((date) {
      if (name.isEmpty || date.isEmpty) {
        firstTime = true;
      } else {
        firstTime = false;
      }
    });
  });

  return firstTime;
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1080, 2160),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Pregnancy app",
            home: child,
          );
        },
        child: widget.firstTime ? const NamePage() : const Homepage());
  }
}
