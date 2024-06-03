import 'package:coba/variables/api_key.dart';
import 'package:coba/class/session_chunk_history.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/class/response.dart';
import 'package:coba/class/session.dart';
import 'package:coba/class/session_history.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

Future<String> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('${apiUrl}api-token-auth/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(
        <String, String>{'username': username, 'password': password}),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return jsonDecode(response.body)['token'];
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login.');
  }
}

Future<bool> logout() async {
  final response = await http.post(
    Uri.parse('${apiUrl}logout/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{}),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode == 200) {
    user.userId = '';
    user.token = '';
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return false;
    // throw Exception('Failed to login.');
  }
}

Future<WebSocketChannel> connectSession(sessionId) async {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('${apiUrl}ws/video/$sessionId'));
  return channel;
}

Future<Session> startSession() async {
  final response = await http.post(
    Uri.parse('${apiUrl}start/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{
      'user_id': user.userId,
    }),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Session.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to start session.');
  }
}

Future stopSession(int sessionId) async {
  final response = await http.post(
    Uri.parse('${apiUrl}end/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{
      'user_id': user.userId,
      'session_id': sessionId.toString(),
    }),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode != 200) {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to stop session.');
  }
}

Future saveSession(int sessionId, String title) async {
  final response = await http.post(
    Uri.parse('${apiUrl}save/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{
      'user_id': user.userId,
      'session_id': sessionId.toString(),
      'title': title,
    }),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode != 200) {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to save session.');
  }
}

Future<List<SessionHistory>> getSessionList() async {
  final response = await http.post(
    Uri.parse('${apiUrl}session_list/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{
      'user_id': user.userId,
    }),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode == 200) {
    Response res =
        Response.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    List<SessionHistory> result = [];
    for (var i = 0; i < res.data.length; i++) {
      result.add(SessionHistory.fromJson(res.data[i]));
    }
    return result;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get session list.');
  }
}

Future<List<SessionChunk>> getSessionChunkList(int sessionId) async {
  if (kDebugMode) {
    print("getting session chunk...");
  }

  final response = await http.post(
    Uri.parse('${apiUrl}session_chunk_list/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Token ${user.token}',
    },
    body: jsonEncode(<String, String>{
      'user_id': user.userId,
      'session_id': sessionId.toString()
    }),
  );

  if (kDebugMode) {
    print("response = ${response.statusCode}");
  }
  if (response.statusCode == 200) {
    Response res =
        Response.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    if (kDebugMode) {
      print(res.data);
    }

    List<SessionChunk> result = [];
    for (var i = 0; i < res.data.length; i++) {
      result.add(SessionChunk.fromJson(res.data[i]));
    }

    if (kDebugMode) {
      print(result[0].videoUrl);
    }
    return result;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get session chunk list.');
  }
}
