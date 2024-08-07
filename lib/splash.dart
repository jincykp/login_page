import 'package:flutter/material.dart';
import 'package:log_in2/home.dart';
import 'package:log_in2/login.dart';
import 'package:log_in2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'WELCOME',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 16, 27),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ScreenLogin(),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    // _sharedPrefs.setBool(SAVE_KEY_NAME, true);
    final _userLoggedIn = _sharedPrefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctxl) => ScreenHome()));
    }
  }
}
