import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'localization/localization_controller.dart';
// import '../../utils/helpers/check_connectivity.dart';
import 'navigation_menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCntr = Get.find<LocalizationController>();
    log("lang code in app.dart ${localizationCntr.language}");
    // Get.put(CheckConnectivityOfApp(ctx: context));

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (ctx,child) => GetMaterialApp(
        title: 'Rayeh App', 
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(),
        darkTheme: ThemeData(),
        // until make it dynamic with getx.
        locale: localizationCntr.language,
        // locale: const Locale('ar'),
        localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
        supportedLocales: S.delegate.supportedLocales,
        home: NavigationBottomMenu(),
      ),
    );
  }
}
