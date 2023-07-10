import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class AlertsPage extends StatefulWidget {
  AlertsPage();

  @override
  State<StatefulWidget> createState() {
    return _AlertsPageState();
  }
}

Widget _buildNavigationButton(
    BuildContext context, String buttonText, String routeString) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () => Navigator.pushNamed(context, routeString),
  );
}

class _AlertsPageState extends State<AlertsPage> {
  List _items = [];
  List _reg_nos = [];

  // Fetch content from the json file
  Future<void> readJson(final firedata) async {
    final String response = await rootBundle.loadString('assets/data.json');
    // final data = await json.decode(response);
    final data = firedata;
    print(data);

    setState(() {
      List xyz = data["data"]["notificationList"];
      List abc = [];
      List def = [];
      List kmn = [];
      for (int i = 0; i < xyz.length; i++) {
        abc.add(xyz[i]["notification"]);
      }

      for (var obj in abc) {
        String body = obj['body'];
        String replacedString =
            body.replaceAll("Reg. No. :", "Registration Number :");
        String morrep = replacedString.replaceAll('Ltrs', 'Liters');
        replacedString = morrep;
        obj['body'] = replacedString;
        kmn.add(obj);
        body = replacedString;
        int startIndex = body.indexOf('Registration Number :') +
            'Registration Number :'.length;
        int endIndex = body.indexOf('\n', startIndex);
        String regNo = body.substring(startIndex, endIndex).trim();
        def.add(regNo);
      }
      _reg_nos = def;
      _items = kmn;
      // print(_items);
    });
  }

  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  createAlertDialog(BuildContext context, String abc) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(abc),
            content: Image.asset(
              'assets/images/truck.jpg',
              width: 400.0,
              height: 240.0,
              fit: BoxFit.cover,
            ),
            // actions: [speak("Fuel left is 50 Litres")],
          );
        });
  }

  @override
  void initState() {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("Notifications");
      ref.onValue.listen((event) {
        print(event.snapshot.value);
        readJson(event.snapshot.value);
      });
    } catch (error) {
      print(error);
    }
    super.initState();
    // readJson();
    // Call the readJson method when the app starts
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _onItemTapped(int index) {
      if (index == 1) {
        Navigator.pushReplacementNamed(context, '/feed');
      } else if (index == 0) {
        Navigator.pushReplacementNamed(context, '/login');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/speech');
      } else if (index == 4) {
        Navigator.pushReplacementNamed(context, '/map');
      } else if (index == 5) {
        Navigator.pushReplacementNamed(context, '/open');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text("Vehicles"),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(10),
                      // child: ElevatedButton(
                      //     style: ButtonStyle(
                      //       backgroundColor:
                      //           MaterialStateProperty.all(Colors.teal),
                      //     ),
                      //     onPressed: () => {
                      //           createAlertDialog(context, _items[index]["body"]),
                      //           speak(_items[index]["body"])
                      //         },
                      //     child: Text("Vehicle Reg. No. : " +
                      //         _reg_nos[index] +
                      //         "\n\n (Click to Open)")),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: width - 40,
                            color: Colors.teal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Image.asset(
                                    'assets/images/truck.jpg',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Text(
                                          _reg_nos[index],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'On Trip',
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, '/map');
                                              },
                                              child: Text("Navigate"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, '/speech');
                                              },
                                              child: Text("Details"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          Container(
                                            height: 40,
                                            child: FloatingActionButton(
                                              onPressed: () {
                                                speak("Registration Number: " +
                                                    _reg_nos[index].toString() +
                                                    ". " +
                                                    "Status: On Trip" +
                                                    ".");
                                              },
                                              child: Icon(
                                                  Icons.volume_down_rounded),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
              ),
            )
          ],
        ),
      ),
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
