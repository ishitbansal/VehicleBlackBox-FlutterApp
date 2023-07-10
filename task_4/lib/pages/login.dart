import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Center(
          child: Text('Cyrrup Solutions Pvt. Ltd.'),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vehicle Notifications',
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              child: Text('Click Here'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/feed'),
            ),
          ],
        ),
      ),
    );
  }
}
