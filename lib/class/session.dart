class Session {
  final int sessionId;

  Session(this.sessionId);

  Session.fromJson(Map<String, dynamic> json)
      : sessionId = json['response_id'] as int;

  Map<String, dynamic> toJson() => {
        'session_id': sessionId,
      };
}
