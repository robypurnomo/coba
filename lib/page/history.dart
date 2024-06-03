import 'package:coba/api/api.dart';
import 'package:coba/variables/globals.dart';
// import 'package:coba/page/setting.dart';
// import 'package:coba/page/track.dart';
import 'package:coba/variables/ui_material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coba/page/detail_history.dart';
import 'package:coba/class/session_history.dart';
// import 'package:flutter/widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  late Future<List<SessionHistory>> sessionHistory = getSessionList();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        sessionHistory = getSessionList();
      });
    });

    // sessionHistory = getSessionList();
    sessionHistory.then((val) {
      if (kDebugMode) {
        print(val[1].id.toString());
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
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  "Hello, ${user.userId}",
                  style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 20.0),
                height: 5,
                color: lightGreen,
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 10.0),
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.black,
                child: FutureBuilder(
                    future: sessionHistory,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Your last session",
                                      style: TextStyle(
                                        color: lightGreen,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.last.name.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.last.startAt
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Cisitu  ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.white,
                                              // size: 50,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailHistoryPage(snapshot.data!.last.id),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: const Text(
                  "History",
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
                child: FutureBuilder<List<SessionHistory>>(
                  future: sessionHistory,
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
                              color: grey,
                              child: ListTile(
                                textColor: Colors.white,
                                // title: Text(snapshot.data![index].name.toString()),
                                title: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].startAt
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].name.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "30 menit",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Cisitu  ",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.white,
                                                // size: 50,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailHistoryPage(
                                          snapshot.data![index].id),
                                    ),
                                  );
                                },
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
        Positioned(bottom: 0, child: buildBottomNavigationBar(context))
      ],
    ));
  }
}
