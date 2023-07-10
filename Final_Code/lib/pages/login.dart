import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _handleMicrophonePermission() async {
    final status = await Permission.microphone.status;
    if (status == PermissionStatus.granted) {
      print('permision recieved!!!!');
    } else {
      print('no permission :((((((');
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController regnumController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';
  late TextEditingController _fieldtoset;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await [Permission.microphone].request();
    });
    _fieldtoset = nameController;
    _initSpeechState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    regnumController.dispose();
    mobileController.dispose();
  }

  Future<void> _initSpeechState() async {
    bool isAvailable = await _speech.initialize(onStatus: (status) {
      print('onStatus: $status');
      setState(() {
        _isListening = status == _isListening;
      });
    }, onError: (error) {
      print('onError: $error');
      setState(() {
        _isListening = false;
        _speech.stop();
        _transcription = '';
      });
    });
    if (isAvailable) {
      setState(() => _isListening = true);
    } else {
      print('The user has denied the use of speech recognition.');
    }
  }

  void _startListening(TextEditingController controller) {
    _fieldtoset = controller;
    if (_speech.isAvailable) {
      _speech.listen(
        onResult: (result) => setState(() {
          _transcription = result.recognizedWords;
          _fieldtoset.text = _transcription;
          print(_transcription);
        }),
      );
    } else {
      print('Speech recognition not available');
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
      _transcription = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if (index == 3) {
        Navigator.pushReplacementNamed(context, '/speech');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/feed');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/alerts');
      } else if (index == 4) {
        Navigator.pushReplacementNamed(context, '/map');
      } else if (index == 5) {
        Navigator.pushReplacementNamed(context, '/open');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyrrup'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Cyrrup-Logo.png',
                  width: 600.0,
                  height: 240.0,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Vehicle Black Box',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.mic),
                      onTap: () {
                        print('speech');
                        _handleMicrophonePermission();
                        _startListening(nameController);
                      },
                      onLongPress: () {
                        _stopListening();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: regnumController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Registration Number',
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.mic),
                      onTap: () {
                        print('speech');
                        _handleMicrophonePermission();
                        _startListening(regnumController);
                      },
                      onLongPress: () {
                        _stopListening();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: mobileController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.mic),
                      onTap: () {
                        print('speech');
                        _handleMicrophonePermission();
                        _startListening(mobileController);
                      },
                      onLongPress: () {
                        _stopListening();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      print(nameController.text);
                      print(regnumController.text);
                      print(mobileController.text);
                      Navigator.pushReplacementNamed(context, '/feed');
                    },
                  )),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xBBC2C2C4),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic,
            ),
            label: 'login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car,
            ),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Geofence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
