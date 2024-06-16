import 'dart:async';
import 'package:coba/api/api.dart';
import 'package:coba/variables/api_key.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/class/session.dart';
import 'package:coba/variables/ui_material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
import 'package:web_socket_channel/web_socket_channel.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  TrackPageState createState() => TrackPageState();
}

class TrackPageState extends State<TrackPage> {
  bool isTracking = false;
  bool doneTracking = false;
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
      doneTracking = false;
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
      doneTracking = true;
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
              // border: OutlineInputBorder(),
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
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF908c8c),
                    Color(0xFF2c2c2c),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(top: 40, left: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        // size: 50,
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.only(
                        left: 40, top: 80, bottom: 20, right: 40),
                    child: Center(
                      child: Text(
                        'Tracker is ${isTracking ? 'Running' : 'Stopped'}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: StreamBuilder(
                        stream: channel.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (kDebugMode) {
                              print("data : ${snapshot.data}");
                            }
                            // img.Image image =
                            //     img.decodeJpg(snapshot.data as Uint8List)
                            //         as img.Image;
                            return Image.memory(
                              // img.encodeJpg(image),
                              snapshot.data as Uint8List,
                              gaplessPlayback: true,
                            );
                          } else {
                            if (kDebugMode) {
                              print("null");
                            }
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
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 40.0, right: 40.0, bottom: 25.0, top: 25),
                  decoration: const BoxDecoration(
                    color: lightGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                              child: Text(
                            "Time elapsed",
                            style: TextStyle(
                                color: lightGreen,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ))),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Center(
                            child: Text(
                              formatTime(secondsElapsed),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(bottom: 0, child: buildBottomNavigationBar(context))
        ]));
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 75,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 25.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    color: isTracking == true ? Colors.black : lightGreen,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: TextButton(
                    onPressed: isTracking ? null : startTracking,
                    child: Text(
                      (doneTracking == true) ? "Restart" : "Start",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    color: isTracking == true ? lightGreen : Colors.black,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: TextButton(
                    onPressed: isTracking ? stopTracking : null,
                    child: const Text("Stop",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    color: doneTracking == true ? lightGreen : Colors.black,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: TextButton(
                    onPressed: doneTracking ? saveTrackingData : null,
                    child: const Text("Save",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
