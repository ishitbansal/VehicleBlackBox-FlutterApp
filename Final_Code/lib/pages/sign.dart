import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
    );
  }

  void _handleSignup() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both username and password';
      });
      return;
    }

    // TODO: Implement login logic here
    print('Username: $username');
    print('Password: $password');

    Map<String, dynamic> data = {'Uname': username, 'Password': password};

    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Users");
      DatabaseReference fref = ref.child('/');
      fref.push().set(data);
      Navigator.pushNamed(context, '/open');
    } catch (error) {
      print(error);
    }
    // If login is successful, navigate to the home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Cyrrup - Vehicle Blackbox App'),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Signup',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/Cyrrup-Logo.png',
                    width: 600.0,
                    height: 240.0,
                  ),
                ),
                _buildUsernameField(),
                _buildPasswordField(),
                SizedBox(height: 24),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                ElevatedButton(
                  child: Text('Signup'),
                  onPressed: _handleSignup,
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      child: Text('or Login'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/open');
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
