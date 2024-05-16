import 'package:coba/api/api.dart';
import 'package:coba/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
        child: ListTile(
            textColor: Colors.white,
            title: const Text("Logout"),
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.logout),
            ),
            tileColor: const Color.fromARGB(255, 0, 156, 133),
            onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Yakin ingin keluar?"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            final MyHomePageState? homePageState = context
                                .findAncestorStateOfType<MyHomePageState>();
                            if (homePageState != null) {
                              homePageState.updateLoginStatus(false);
                              if (kDebugMode) {
                                print("disini");
                              }
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Iya'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tidak'),
                        ),
                      ],
                    );
                  },
                )),
      ),
      Card(
        child: ListTile(
            textColor: Colors.white,
            title: const Text("Logout"),
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.logout),
            ),
            tileColor: const Color.fromARGB(255, 0, 156, 133),
            onTap: () {
              Future<bool> success = logout();
              success.then((val) {
                if (val) {
                  final MyHomePageState? homePageState =
                      context.findAncestorStateOfType<MyHomePageState>();
                  if (homePageState != null) {
                    homePageState.updateLoginStatus(false);
                  }
                }
              });
            }),
      )
    ]);
  }
}
