import 'package:bloc_mvvm/bloc/auth_bloc/auth_bloc.dart';
import 'package:bloc_mvvm/config/colors.dart';
import 'package:bloc_mvvm/config/components/custom_button.dart';
import 'package:bloc_mvvm/config/components/snakbars.dart';
import 'package:bloc_mvvm/config/routes/routes.dart';
import 'package:bloc_mvvm/config/routes/routes_name.dart';
import 'package:bloc_mvvm/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up Screen"),
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
                      validator: (value) =>
                          value!.isEmpty ? "Enter Email" : null,
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
                      validator: (value) =>
                          value!.isEmpty ? "Enter Password" : null,
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
                      listener: (context, state) {
                        if (state.authStatus == AuthStatus.success) {
                          Snakbars.flushBar(
                            context,
                            "Sign Up : ${state.msg}",
                            AppColors.greenColor,
                          );
                        }
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            title: "Sign Up",
                            bgColor: AppColors.greenColor,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    email: _email.text,
                                    password: _password.text));
                                // Snakbars.simpleSnackBar(context,
                                //     "Email : ${_email.text}\nPassword : ${_password.text}");
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
                        Routes().pushnamedAndRemovedUntil(context, loginRoute);
                      },
                      child: const Text("Back to Login"),
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
