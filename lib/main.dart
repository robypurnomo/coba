import 'package:coba/page/login_page.dart';
import 'package:coba/page/splash_screen.dart';
import 'package:flutter/foundation.dart';
// import 'package:coba/variables/ui_material.dart';
import 'package:flutter/material.dart';
import 'package:coba/page/history.dart';
// import 'package:coba/page/track.dart';
// import 'package:coba/page/setting.dart';
import 'package:coba/variables/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Workout Counter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // int _selectedIndex = 2;
  PageController controller = PageController(initialPage: 0);

  // static final List<Widget> _widgetOptions = <Widget>[
  //   const TrackPage(),
  //   const SettingPage(),
  //   const HistoryPage(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void updateLoginStatus(bool status) {
    setState(() {
      if (kDebugMode) {
        print("saiko");
      }
      globals.isLoggedIn = status;
    });
  }

  // PreferredSizeWidget? _buildAppBar() {
  //   if (globals.isLoggedIn) {
  //     return AppBar(
  //       title: const Text(
  //         'Personal Workout Counter',
  //       ),
  //       foregroundColor: Colors.white,
  //       backgroundColor: const Color.fromARGB(255, 0, 156, 133),
  //     );
  //   } else {
  //     return null; // Tidak menampilkan AppBar jika pengguna belum login
  //   }
  // }

  // Widget? _buildBottomNavigationBar() {
  //   if (globals.isLoggedIn) {
  //     return Container(
  //       height: 75,
  //       margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 25.0),
  //       decoration: const BoxDecoration(
  //         color: lightGreen,
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(50),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           SizedBox(
  //             height: 75,
  //             width: 200,
  //             child: IconButton(
  //                 enableFeedback: false,
  //                 onPressed: () {
  //                   setState(() {
  //                     _selectedIndex = 0;
  //                   });
  //                 },
  //                 icon: const Icon(
  //                   Icons.camera,
  //                   color: Colors.black,
  //                   size: 50,
  //                 )),
  //           ),
  //           Container(
  //             height: 75,
  //             width: 225,
  //             decoration: const BoxDecoration(
  //               color: Colors.black,
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(50),
  //               ),
  //             ),
  //             child: IconButton(
  //               enableFeedback: false,
  //               onPressed: () {
  //                 setState(() {
  //                   _selectedIndex = 1;
  //                 });
  //               },
  //               icon: const Icon(
  //                 Icons.settings,
  //                 color: lightGreen,
  //                 size: 45,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     );
  //   } else {
  //     return null; // Tidak menampilkan BottomNavigationBar jika pengguna belum login
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: _buildAppBar(),
        body: PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (widget._navigatorKey.currentState!.canPop()) {
          widget._navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: widget._navigatorKey,
        initialRoute: '/splash',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (_) {
                if (globals.isLoggedIn) {
                  return const HistoryPage();
                } else {
                  return const LoginPage();
                  // return const SplashScreen();
                }
              };
              break;
            case '/splash':
              builder = (_) => const SplashScreen();
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    ));
    // bottomNavigationBar: _buildBottomNavigationBar());
  }
}
