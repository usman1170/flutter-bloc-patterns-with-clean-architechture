import 'dart:developer';

class Validations {
  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    log(regExp.hasMatch(email).toString());
    return regExp.hasMatch(email);
  }
}
