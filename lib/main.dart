import 'package:coba/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:coba/page/history.dart';
import 'package:coba/page/track.dart';
import 'package:coba/page/setting.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  PageController controller = PageController(initialPage: 0);

  static final List<Widget> _widgetOptions = <Widget>[
    const SettingPage(),
    const TrackPage(),
    const HistoryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void updateLoginStatus(bool status) {
    setState(() {
      globals.isLoggedIn = status;
    });
  }

  PreferredSizeWidget? _buildAppBar() {
    if (globals.isLoggedIn) {
      return AppBar(
        title: const Text(
          'Personal Workout Counter',
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 156, 133),
      );
    } else {
      return null; // Tidak menampilkan AppBar jika pengguna belum login
    }
  }

  Widget? _buildBottomNavigationBar() {
    if (globals.isLoggedIn) {
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color.fromARGB(255, 0, 156, 133),
        onTap: _onItemTapped,
      );
    } else {
      return null; // Tidak menampilkan BottomNavigationBar jika pengguna belum login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        // body: Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (_navigatorKey.currentState!.canPop()) {
              _navigatorKey.currentState!.pop();
            }
          },
          child: Navigator(
            key: _navigatorKey,
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case '/':
                  builder = (_) {
                    if (globals.isLoggedIn) {
                      return _widgetOptions[_selectedIndex];
                    } else {
                      return LoginPage(updateLoginStatus, controller);
                    }
                  };
                  break;
                // case '/setting':
                //   builder = (_) => SettingPage();
                //   break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar());
  }
}
