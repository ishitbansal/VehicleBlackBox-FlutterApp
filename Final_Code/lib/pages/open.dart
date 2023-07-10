import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class OpenPage extends StatefulWidget {
  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> with TickerProviderStateMixin {
  List<dynamic> Users = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> readJson(final firedata) async {
    final data = firedata;
    List<dynamic> temp = [];

    setState(() {
      data.forEach((key, value) {
        print('Key: $key, Value: $value');
        Map<String, dynamic> d = {
          'Uname': data[key]['Uname'],
          'Password': data[key]['Password']
        };
        temp.add(d);
      });
      Users = temp;
      print(Users);
    });
  }

  int _currentIndex = 0;
  List<String> _imagePaths = [
    'assets/images/Cyrrup-Logo.png',
    'assets/images/SFM.jpeg',
  ];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    List x = [];
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Users");
      ref.onValue.listen((event) {
        print(event.snapshot.value);
        readJson(event.snapshot.value);
      });
    } catch (error) {
      print(error);
    }

    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    // Define the animation object
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start a timer to switch images every 2 seconds
    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imagePaths.length;
        _controller.reset();
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller
    _controller.dispose();
    super.dispose();
  }

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

  void _handleLogin() {
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
    // print(Users);

    for (var user in Users) {
      if (user['Uname'] == username) {
        if (user['Password'] == password) {
          print('Yes! correct');
          Navigator.pushNamed(context, '/login');
          break;
        } else {
          setState(() {
            _errorMessage = 'Incorrect Password';
          });
          return;
        }
      }
    }
    // Navigator.pushNamed(context, '/login');
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
                Text('Welcome to Our App!\n Login or Signup to Continue',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                    )),
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    _imagePaths[_currentIndex],
                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.width - 20,
                  ),
                ),
                SizedBox(width: 16),
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
                  child: Text('Login'),
                  onPressed: _handleLogin,
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      child: Text('or Signup'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    )),
              ],
            ),
          ),
        ));
  }
}
