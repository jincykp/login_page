import 'package:flutter/material.dart';
import 'package:log_in2/home.dart';
import 'package:log_in2/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isDataMatched = true;
  final _formKey = GlobalKey<FormState>();
  final _user = 'admin';
  final _pass = 'ad';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: "User Name",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Username'),
                  validator: (value) {
                    // if (_isDataMatched) {
                    // return null;
                    // } else {
                    //   return ' Error';
                    //   }
                    if (value == null || value.isEmpty) {
                      return 'username  is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 5)),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.lock_rounded, size: 24),
                      hintText: 'password'),
                  validator: (value) {
                    //if (_isDataMatched)    {
                    //return null;
                    // } else {
                    //   return ' Error';
                    // }
                    if (value == null || value.isEmpty) {
                      return 'password is empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !_isDataMatched,
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    //-------button-----------
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkLogin(context);
                        } else {
                          print('Data Empty');
                        }

                        //checkLogin(context);
                      },
                      icon: const Icon(Icons.check),
                      label: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;
    if (_username == _user && _password == _pass) {
      print("username pass is match");

      //Goto Home
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);

      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctxl) => ScreenHome()));
    } else {
      //snackbar-------
      final _errorMessage = 'Username and Password not Match!!';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            _errorMessage,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )));
      print("not match");
      print("Username password does not match");
      setState(() {
        _isDataMatched = false;
      });
    }
  }
}
