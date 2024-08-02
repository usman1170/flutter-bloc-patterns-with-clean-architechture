import 'package:bloc_mvvm/config/colors.dart';
import 'package:bloc_mvvm/config/routes/routes.dart';
import 'package:bloc_mvvm/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Routes().pushnamedAndRemovedUntil(context, loginRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "BLOC MVVM",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.greenColor),
        ),
      ),
    );
  }
}
