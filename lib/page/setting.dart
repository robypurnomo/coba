import 'package:coba/api/api.dart';
import 'package:coba/main.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/variables/ui_material.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final BuildContext prevContext;
  const SettingPage(this.prevContext, {super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: lightGreen),
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
            margin: const EdgeInsets.only(left: 40, top: 80, bottom: 20),
            child: const Text(
              "Setting",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  user.userId,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 20),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  user.password,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 10),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle tap
              if (kDebugMode) {
                print('Container tapped');
              }
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text("Are you sure want to logout?"),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          final MyHomePageState? homePageState = widget
                              .prevContext
                              .findAncestorStateOfType<MyHomePageState>();
                          if (homePageState != null) {
                            Future<bool> success = logout();
                            success.then((val) {
                              if (val) {
                                homePageState.updateLoginStatus(false);
                                Navigator.of(dialogContext).pop();
                                Navigator.of(context).pop();
                              }
                            });
                          } else {
                            if (kDebugMode) {
                              print("state not found");
                            }
                          }
                          // if (homePageState != null) {
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40, top: 50, right: 40),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
