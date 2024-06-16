import 'package:coba/api/api.dart';
import 'package:coba/variables/ui_material.dart';
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
        body: Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0),
          child: ListView(
            children: [
              Container(
                height: 65,
                margin: const EdgeInsets.only(bottom: 10.0),
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 75,
                        height: 65,
                        decoration: const BoxDecoration(
                          color: lightGreen,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            // size: 50,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: const Text(
                  "Detail",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: 5,
                color: lightGreen,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                // margin: const EdgeInsets.only(top: 120.0, bottom: 60.0),
                child: FutureBuilder<List<SessionChunk>>(
                  future: historyItemList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: Colors.black,
                              child: ListTile(
                                textColor: Colors.white,
                                // title: Text(snapshot.data![index].name.toString()),
                                title: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].positionType
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                top: 20.0, bottom: 20),
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              child: FlickVideoPlayer(
                                                flickManager: FlickManager(
                                                    autoPlay: false,
                                                    videoPlayerController:
                                                        VideoPlayerController
                                                            .networkUrl(Uri.parse(
                                                                ("${videoUrl}static/${snapshot.data![index].videoUrl}")))),
                                              ),
                                            )),
                                        Text(
                                          'Total ${snapshot.data![index].positionType.toString().toLowerCase()} : ${snapshot.data![index].count}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          'Correct ${snapshot.data![index].positionType.toString().toLowerCase()} : ${snapshot.data![index].count}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    // By default, show a loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
