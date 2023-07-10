// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// class SpeechPage extends StatefulWidget {
//   SpeechPage();
//
//   @override
//   State<StatefulWidget> createState() {
//     return _SpeechPageState();
//   }
// }
//
// class _SpeechPageState extends State<SpeechPage> {
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController textEditingController = TextEditingController();
//
//   speak(String text) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _onItemTapped(int index) {
//       if (index == 0) {
//         Navigator.pushReplacementNamed(context, '/login');
//       } else if (index == 1) {
//         Navigator.pushReplacementNamed(context, '/feed');
//       } else if (index == 3) {
//         Navigator.pushReplacementNamed(context, '/alerts');
//       } else if (index == 4) {
//         Navigator.pushReplacementNamed(context, '/map');
//       } else if (index == 5) {
//         Navigator.pushReplacementNamed(context, '/open');
//       }
//     }
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Center(
//               child: Text(
//             'Text to Speech Converter',
//           )),
//           backgroundColor: Colors.orange,
//         ),
//         backgroundColor: Colors.white,
//         body: Container(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.all(32),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextFormField(
//                   controller: textEditingController,
//                 ),
//                 ElevatedButton(
//                   child: Text('Text To Speech'),
//                   onPressed: () => {speak(textEditingController.text)},
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Color(0xBBC2C2C4),
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Colors.blue,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.login,
//               ),
//               label: 'login',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.record_voice_over),
//               label: 'Vehicles',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add_alert),
//               label: 'Alerts',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.location_on),
//               label: 'Geofence',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.logout),
//               label: 'Logout',
//             ),
//           ],
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class VehiclesPage extends StatefulWidget {
  VehiclesPage();

  @override
  State<StatefulWidget> createState() {
    return _VehiclesPageState();
  }
}

Widget _buildNavigationButton(
    BuildContext context, String buttonText, String routeString) {
  return ElevatedButton(
    child: Text(buttonText),
    onPressed: () => Navigator.pushNamed(context, routeString),
  );
}

class _VehiclesPageState extends State<VehiclesPage> {
  List _items = [];
  List _reg_nos = [];
  List _titles = [];
  List _quants = [];
  List _cur_fuel = [];

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
      List tem = [];
      List q = [];
      List cur = [];
      for (int i = 0; i < xyz.length; i++) {
        abc.add(xyz[i]["notification"]);
        tem.add(xyz[i]["title"]);
        q.add(xyz[i]["quantity"]);
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

        startIndex =
            body.indexOf('Current Fuel Level:') + 'Current Fuel Level:'.length;
        endIndex = body.length - 1;
        String cl = body.substring(startIndex, endIndex).trim();
        cl = cl.replaceAll('Liter', 'Liters');
        cur.add(cl);
      }
      _reg_nos = def;
      _items = kmn;
      _titles = tem;
      _cur_fuel = cur;
      _quants = q;
      print(_titles);
      print(_cur_fuel);
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
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/login');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text("Alerts"),
        ),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: width - 20,
                            color: Colors.teal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    size: 50,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          _titles[index],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Registration no.: " +
                                              _reg_nos[index],
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          _titles[index] +
                                              ": " +
                                              _quants[index].toString() +
                                              " Ltrs",
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Current fuel level: " +
                                              _cur_fuel[index].toString(),
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      speak(_titles[index] +
                                          ". Registration number: " +
                                          _reg_nos[index] +
                                          ". " +
                                          _titles[index] +
                                          ": " +
                                          _quants[index].toString() +
                                          " Litres." +
                                          "Current fuel level: " +
                                          _cur_fuel[index].toString());
                                    },
                                    child: Icon(Icons.volume_down_rounded),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
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
