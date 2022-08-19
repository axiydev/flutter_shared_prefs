class UserModel {
  String? login;
  String? password;
  String? token;
  UserModel({required this.login, required this.password, required this.token});

  UserModel.fromJson(Map<String, dynamic> json)
      : login = json['login'],
        password = json['password'],
        token = json['token'];

  UserModel copyWith({String? token, String? login, String? password}) {
    return UserModel(
        login: login ?? this.login,
        password: password ?? this.password,
        token: token ?? this.token);
  }

  Map<String, dynamic> toJson() {
    return {'login': login, 'password': password, 'token': token};
  }
}
