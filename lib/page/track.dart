import 'dart:async';
import 'package:coba/api/api.dart';
import 'package:coba/variables/api_key.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/class/session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:image/image.dart' as img;
import 'package:web_socket_channel/web_socket_channel.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  TrackPageState createState() => TrackPageState();
}

class TrackPageState extends State<TrackPage> {
  bool isTracking = false;
  int secondsElapsed = 0;
  Timer? timer;
  late Future<Session> session;
  final myController = TextEditingController();
  WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('$wsUrl/ws/stream'));

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print(user.token);
    }
  }

  void startTracking() {
    setState(() {
      isTracking = true;
      secondsElapsed = 0;
      session = startSession();
      channel = WebSocketChannel.connect(Uri.parse('$wsUrl/ws/stream'));
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  void stopTracking() {
    setState(() {
      session.then((val) {
        stopSession(val.sessionId);
      });

      isTracking = false;
      timer?.cancel();
    });
  }

  void saveTrackingData() {
    setState(() {
      secondsElapsed = 0;
    });
    if (kDebugMode) {
      print('Data disimpan. Waktu yang digunakan: $secondsElapsed detik');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Save Data"),
          content: TextField(
            controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan nama',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                session.then((val) {
                  saveSession(val.sessionId, myController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String formatTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tracker is ${isTracking ? 'Running' : 'Stopped'}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              'Time Elapsed: ${formatTime(secondsElapsed)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            // FutureBuilder<WebSocketChannel>(
            //   future: connectSession(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return
            //     }
            //     // By default, show a loading spinner.
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // ),
            Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (kDebugMode) {
                        print("data : ${snapshot.data}");
                      }
                      // final message = snapshot.data
                      //     as List<MqttReceivedMessage<MqttMessage?>>?;
                      // final recvMessage =
                      //     message![0].payload as MqttPublishMessage;
                      img.Image image = img
                          .decodeJpg(snapshot.data as Uint8List) as img.Image;
                      return Image.memory(
                        img.encodeJpg(image),
                        gaplessPlayback: true,
                      );
                    } else {
                      if (kDebugMode) {
                        print("null");
                      }
                      // return Text('${snapshot.data}');

                      // return const Center(
                      //     child: CircularProgressIndicator(
                      //         valueColor:
                      //             AlwaysStoppedAnimation<Color>(Colors.black)));
                      return Center(
                        child: Image.asset(
                          "assets/images/A_black_image.jpg",
                          // width: 413,
                          // height: 457,
                        ),
                      );
                    }
                  },
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: isTracking ? null : startTracking,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: isTracking ? stopTracking : null,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: isTracking ? null : saveTrackingData,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
