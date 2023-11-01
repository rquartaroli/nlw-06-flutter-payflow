import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow_project/modules/barcode_scanner/barcode_scanner_page.dart';
import 'package:payflow_project/modules/home/home_page.dart';
import 'package:payflow_project/modules/insert_bill/insert_bill_page.dart';
import 'package:payflow_project/modules/login/login_page.dart';
import 'package:payflow_project/modules/splash/splash_page.dart';
import 'package:payflow_project/shared/models/user_model.dart';
import 'package:payflow_project/shared/themes/app_colors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payflow Project',
      theme: ThemeData(
        primarySwatch: Colors.orange, primaryColor: AppColors.primary,
        useMaterial3: true,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginPage(),
        "/home": (context) => HomePage(
          user: ModalRoute.of(context)!.settings.arguments as UserModel,
        ),
        "/barcode_scanner": (context) => const BarcodeScannerPage(),
        "/insert_bill": (context) => InsertBillPage(
          barcode: ModalRoute.of(context) != null 
                ?  ModalRoute.of(context)!.settings.arguments.toString()
                : null),
      },
    );
  }
}