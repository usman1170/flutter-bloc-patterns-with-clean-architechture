import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_mvvm/data/exceptions/app_exceptions.dart';
import 'package:bloc_mvvm/data/network/base_api_Services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      jsonResponse = apiResponses(response);
      return jsonResponse;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOutException();
    } catch (e) {
      GeneraicException(e.toString());
    }
    return jsonResponse;
  }

  @override
  Future postApi(String url, data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 20));
      jsonResponse = apiResponses(response);
      return jsonResponse;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw RequestTimeOutException();
    } catch (e) {
      jsonResponse = e;
      GeneraicException(e.toString());
    }

    log("json res in network $jsonResponse");
    return jsonResponse;
  }

  apiResponses(http.Response response) {
    log("Api response ${response.statusCode.toString()}");
    switch (response.statusCode) {
      case 200:
        dynamic res = jsonDecode(response.body);
        return res;
      case 400:
        dynamic res = jsonDecode(response.body);
        return res;
      // throw BadRequestException(
      //     "${response.body.toString()} ${response.statusCode.toString()}");
      case 401:
      case 404:
        throw NotFoundException(
            "${response.body.toString()} ${response.statusCode.toString()}");
      case 500:
        throw GeneraicException(
            "${response.body.toString()} ${response.statusCode.toString()}");
      default:
        throw GeneraicException(
            "${response.body.toString()} ${response.statusCode.toString()}");
    }
  }
}
