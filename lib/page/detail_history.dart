import 'package:coba/api/api.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coba/class/session_chunk_history.dart';
import 'package:video_player/video_player.dart';
import 'package:coba/variables/api_key.dart';

class DetailHistoryPage extends StatefulWidget {
  final int sessionId;

  const DetailHistoryPage(this.sessionId, {super.key});

  @override
  DetailHistoryState createState() => DetailHistoryState();
}

class DetailHistoryState extends State<DetailHistoryPage> {
  late FlickManager flickManager;
  late Future<List<SessionChunk>> historyItemList =
      getSessionChunkList(widget.sessionId);

  @override
  void initState() {
    super.initState();
    historyItemList.then((val) {
      if (kDebugMode) {
        print(val[0].id.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: FutureBuilder<List<SessionChunk>>(
            future: historyItemList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data![index].positionType != "STANDING") {
                      return Card(
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 20.0),
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index].positionType ??
                                        "Push Up",
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 50.0, right: 50.0, bottom: 10.0),
                                  child: FlickVideoPlayer(
                                    flickManager: FlickManager(
                                        autoPlay: false,
                                        videoPlayerController:
                                            VideoPlayerController.networkUrl(
                                                Uri.parse(
                                                    ("${apiUrl}static/${snapshot.data![index].videoUrl}")))),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0, left: 8.0),
                                  child: Text(
                                    'Jumlah',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 8.0),
                                  child: Text(
                                    '${snapshot.data![index].count} ${snapshot.data![index].positionType}',
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }
                    return null;
                  },
                );
              }
              return const Center(
                  // child: CircularProgressIndicator(),
                  );
            }));
  }
}
