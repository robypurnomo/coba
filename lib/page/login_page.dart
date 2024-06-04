import 'package:coba/api/api.dart';
import 'package:coba/main.dart';
// import 'package:coba/main.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/class/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // final PageController controller;
  // final Function(bool) updateLogin;
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signin() {
    if (kDebugMode) {
      print(_usernameController.text);
      print(_passController.text);
    }
    Future<String> token = login("user1", "CliBBQ17Sm7PIQ7");
    // Future<String> token = login("averrous", "123456");
    // Future<String> token =
    //     login(_usernameController.text, _passController.text);
    token.then((val) {
      // user = User(_usernameController.text, val, _passController.text);
      user = User("user1", val, "CliBBQ17Sm7PIQ7");
      if (kDebugMode) {
        print(val);
      }
    });
    final MyHomePageState? homePageState =
        context.findAncestorStateOfType<MyHomePageState>();
    if (homePageState != null) {
      homePageState.updateLoginStatus(true);
    } else {
      if (kDebugMode) {
        print("ggl");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 13, top: 56),
            child: Text(
              'Log In.', 
              style: TextStyle(
                fontSize: 100, 
                fontWeight: FontWeight.w500,
                color: Color(0xFF1434F4),
              )
            )
          ),
          const Divider(
            thickness: 3,
            color: Color(0xFF1434F4),
            indent: 13,
            endIndent: 13,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 300, top: 0),
            child: Text(
              'Are you ready?', 
              style: TextStyle(
                fontSize: 17, 
                fontWeight: FontWeight.w500,
                color: Color(0xFF1434F4),
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 90,
                ),
                TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1434F4),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Color(0xFF1434F4),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF1434F4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF1434F4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1434F4),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFF1434F4),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF1434F4),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xFF1434F4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 329,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => signin(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB2F562),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     const Text(
                //       'Don’t have an account?',
                //       style: TextStyle(
                //         color: Color.fromARGB(255, 0, 156, 133),
                //         fontSize: 13,
                //         fontFamily: 'Poppins',
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 2.5,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         widget.controller.animateToPage(1,
                //             duration: const Duration(milliseconds: 500),
                //             curve: Curves.ease);
                //       },
                //       child: const Text(
                //         'Sign Up',
                //         style: TextStyle(
                //           color: Color.fromARGB(255, 0, 156, 133),
                //           fontSize: 13,
                //           fontFamily: 'Poppins',
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
