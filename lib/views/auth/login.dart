// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc_mvvm/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc_mvvm/config/colors.dart';
import 'package:bloc_mvvm/config/components/custom_button.dart';
import 'package:bloc_mvvm/config/components/snakbars.dart';
import 'package:bloc_mvvm/config/routes/routes.dart';
import 'package:bloc_mvvm/config/routes/routes_name.dart';
import 'package:bloc_mvvm/utils/enums.dart';
import 'package:bloc_mvvm/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("login top build");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen"),
        ),
        body: BlocProvider(
          create: (context) => _authBloc,
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _email,
                      focusNode: emailFocus,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                      validator: (value) => value!.isEmpty
                          ? "Enter Email"
                          : !Validations().isValidEmail(value)
                              ? "Please Enter Valid Email"
                              : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      focusNode: passwordFocus,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                      validator: (value) => value!.isEmpty
                          ? "Enter Password"
                          : value.length < 6
                              ? "Password must contain atleast 6 characters"
                              : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          current.authStatus != previous.authStatus,
                      listener: (context, state) async {
                        if (state.authStatus == AuthStatus.success) {
                          await Snakbars.flushBar(
                            context,
                            "Success : ${state.msg}",
                            AppColors.greenColor,
                          );
                        }
                        if (state.authStatus == AuthStatus.failed) {
                          await Snakbars.flushBar(
                            context,
                            "Error : ${state.msg}",
                            AppColors.greenColor,
                          );
                        }
                        if (state.authStatus == AuthStatus.loading) {
                          await Snakbars.simpleSnackBar(context, "Loading");
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            title: state.authStatus == AuthStatus.loading
                                ? "Loading..."
                                : "Login",
                            bgColor: AppColors.greenColor,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      LoginEvent(
                                        email: _email.text.toString(),
                                        password: _password.text.toString(),
                                      ),
                                    );
                              } else {}
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Routes().pushnamed(context, signUpRoute);
                      },
                      child: const Text("Didn't have account? Sign Up"),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
