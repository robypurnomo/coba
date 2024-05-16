class Response {
  List data;
  String message;

  Response(
    this.data,
    this.message,
  );

  Response.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String,
        data = json['data'] as List;
}
