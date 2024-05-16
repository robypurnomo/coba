import 'package:coba/api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coba/page/detail_history.dart';
import 'package:coba/class/session_history.dart';

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
    // sessionHistory = getSessionList();
    sessionHistory.then((val) {
      if (kDebugMode) {
        print(val[1].id.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SessionHistory>>(
      future: sessionHistory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  textColor: Colors.white,
                  title: Text(snapshot.data![index].name.toString()),
                  subtitle: Text(snapshot.data![index].startAt.toString()),
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(197, 248, 243, 255),
                    child: Text((snapshot.data![index]).id.toString()),
                  ),
                  tileColor: const Color.fromARGB(255, 0, 156, 133),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailHistoryPage(snapshot.data![index].id),
                      ),
                    );
                  },
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
    );
  }
}
