class User {
  String userId;
  String token;
  String password;

  User(this.userId, this.token, this.password);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as String,
        token = json['token'] as String,
        password = '';

  Map<String, dynamic> toJson() => {
        'user_id': userId,
      };
}
