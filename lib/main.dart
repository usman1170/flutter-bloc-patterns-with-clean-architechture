import 'package:bloc_mvvm/config/routes/routes_name.dart';
import 'package:bloc_mvvm/views/auth/login.dart';
import 'package:bloc_mvvm/views/auth/signup.dart';
import 'package:bloc_mvvm/views/home/home_screen.dart';
import 'package:bloc_mvvm/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc patterns',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        signUpRoute: (context) => const SignUpScreen(),
        homeRoute: (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
