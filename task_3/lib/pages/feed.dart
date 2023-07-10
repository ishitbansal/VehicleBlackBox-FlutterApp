import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class FeedPage extends StatefulWidget {
  FeedPage();

  @override
  State<StatefulWidget> createState() {
    return _FeedPageState();
  }
}

Widget _buildNavigationButton(
    BuildContext context, String buttonText, String routeString) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () => Navigator.pushNamed(context, routeString),
  );
}

class _FeedPageState extends State<FeedPage> {
  List _items = [];
  List _reg_nos = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      List xyz = data["data"]["notificationList"];
      List abc = [];
      List def = [];
      for (int i = 0; i < xyz.length; i++) {
        abc.add(xyz[i]["notification"]);
      }

      for (var obj in abc) {
        String body = obj['body'];
        int startIndex = body.indexOf('Reg. No. :') + 'Reg. No. :'.length;
        int endIndex = body.indexOf('\n', startIndex);
        String regNo = body.substring(startIndex, endIndex).trim();
        def.add(regNo);
      }
      _reg_nos = def;
      _items = abc;
      print(_items);
    });
  }

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  createAlertDialog(BuildContext context, String abc) {
    print(abc);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(abc),
            content: Image.asset(
              'assets/images/truck.jpg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            // actions: [speak("Fuel left is 50 Litres")],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Center(
          child: Text("Vehicles"),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () =>
                    {createAlertDialog(context, "Testing"), speak("Testing")},
                child: Text('Notification (Click)')),
            _buildNavigationButton(context, 'Home', '/login'),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.teal),
                      ),
                      onPressed: () => {
                            createAlertDialog(context, _items[index]["body"]),
                            speak(_items[index]["body"])
                          },
                      child: Text("Vehicle Reg. No. : " + _reg_nos[index]));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
