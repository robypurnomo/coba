import 'package:coba/api/api.dart';
import 'package:coba/main.dart';
// import 'package:coba/main.dart';
import 'package:coba/variables/globals.dart';
import 'package:coba/class/user.dart';
import 'package:coba/variables/ui_material.dart';
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
    // Future<String> token = login("user1", "CliBBQ17Sm7PIQ7");
    // Future<String> token = login("averrous", "123456");
    Future<String> token =
        login(_usernameController.text, _passController.text);
    token.then((val) {
      if (val == '') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Username or password incorrect"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          },
        );
      } else {
        user = User(_usernameController.text, val, _passController.text);
        // user = User("user1", val, "CliBBQ17Sm7PIQ7");
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(left: 13, top: 56),
                    child: Text('Log In.',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w500,
                          color: blue,
                        ))),
                const Divider(
                  thickness: 3,
                  color: blue,
                  indent: 13,
                  endIndent: 13,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 300, top: 0),
                    child: Text('Are you ready?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: blue,
                        ))),
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
                          color: blue,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: blue,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: blue,
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
                          color: blue,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: blue,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () => signin(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightGreen,
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
                      )),
                ))
          ],
        ));
  }
}
