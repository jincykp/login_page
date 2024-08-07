import 'package:flutter/material.dart';
import 'package:log_in2/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(255, 211, 181, 13),
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAlertDialog(context);
              //  signout(context);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text("PERSON $index"),
                subtitle: Text("Message $index"),
                leading: index % 2 == 1
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1607746882042-944635dfe10e?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      )
                    : Container(
                        width: 50,
                        height: 70,
                        child: Image.network(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      ),
                trailing: Text('1$index:00pm'),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider();
            },
            itemCount: 25,
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctxl) => ScreenLogin()), (route) => false);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx1) => ScreenHome()),
        );
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx1) => ScreenLogin()),
            (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention!!!"),
      content: Text("Are you sure do you want to exit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
