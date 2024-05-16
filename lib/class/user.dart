class User {
  String userId;
  String token;

  User(this.userId, this.token);

  User.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as String,
        token = json['token'] as String;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
      };
}
