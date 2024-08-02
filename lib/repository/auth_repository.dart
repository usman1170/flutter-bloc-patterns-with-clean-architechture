import 'package:bloc_mvvm/data/network/network_api_services.dart';
import 'package:bloc_mvvm/models/user_model.dart';
import 'package:bloc_mvvm/utils/helpers.dart';

class AuthRepository {
  final _api = NetworkApiServices();
  Future<UserModel1> login(dynamic data) async {
    final res = await _api.postApi(loginURL, data);
    final userData = UserModel1.fromJson(res);
    return userData;
  }

  Future<UserModel1> signUp(dynamic data) async {
    final res = await _api.postApi(signUpURL, data);
    print(res);
    final userData = UserModel1.fromJson(res);

    return userData;
  }
}
