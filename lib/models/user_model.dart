import 'dart:convert';

class UserModel {
  String token;
  String error;
  UserModel({
    required this.token,
    required this.error,
  });

  UserModel copyWith({
    String? token,
    String? error,
  }) {
    return UserModel(
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'error': error,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? "",
      error: map['error'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(token: $token, error: $error)';
}

class UserModel1 {
  String? token;
  String? error;

  UserModel1({this.token, this.error});

  UserModel1.fromJson(Map<String, dynamic> json) {
    token = json['token'] ?? "";
    error = json['error'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['error'] = error;
    return data;
  }
}
