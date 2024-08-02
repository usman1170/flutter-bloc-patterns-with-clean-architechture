// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _msg;
  final _prefix;
  AppException(this._msg, this._prefix);

  @override
  String toString() {
    return "$_prefix$_msg";
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? msg])
      : super("No Internet Connection", msg ?? "");
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? msg]) : super("Request Time Out", msg ?? "");
}

class BadRequestException extends AppException {
  BadRequestException([String? msg]) : super("Bad Request", msg ?? "");
}

class NotFoundException extends AppException {
  NotFoundException([String? msg]) : super("404 Not Found", msg ?? "");
}

class GeneraicException extends AppException {
  GeneraicException([String? msg]) : super("", msg ?? "");
}
