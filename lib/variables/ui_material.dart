import 'package:coba/page/setting.dart';
import 'package:coba/page/track.dart';
import 'package:flutter/material.dart';

// Color
const Color green = Color.fromARGB(255, 0, 156, 133);
const Color lightGreen = Color(0xffB2F562);
const Color grey = Color(0xff9E9E9E);
const Color blue = Color(0xff1434F4);

// Size
// const double height = MediaQuery.of(context).size.width * 0.65;

// navbar
Widget buildBottomNavigationBar(BuildContext context) {
  return Container(
    height: 75,
    margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 25.0),
    decoration: const BoxDecoration(
      color: lightGreen,
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width * 0.48,
          child: IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrackPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.camera,
                color: Colors.black,
                size: 50,
              )),
        ),
        Container(
          height: 75,
          width: MediaQuery.of(context).size.width * 0.48,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(context),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
              color: lightGreen,
              size: 45,
            ),
          ),
        )
      ],
    ),
  );
}
