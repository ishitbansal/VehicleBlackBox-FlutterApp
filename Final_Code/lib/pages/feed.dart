import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';

class FeedPage extends StatefulWidget {
  FeedPage();

  @override
  State<StatefulWidget> createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage> {
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/login');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/speech');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/alerts');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/map');
    } else if (index == 5) {
      Navigator.pushReplacementNamed(context, '/open');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);
    print(width);

    speak('your monthly theft was 0 litres and your weekly theft was 0 litres');
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Vehicle Black Box"),
        ),
        backgroundColor: Color(0xE3FF9812),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: width / 3,
                      ),
                      Text(
                        'shivam\nshivam@cyrrup.com\n+91 9898888823',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 40,
                thickness: 1.5,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: width * 0.4,
                          height: 140,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Color(0xC2C2C4BB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.local_gas_station,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Last Week\nTheft\n0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: width * 0.4,
                          height: 140,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Color(0xC2C2C4BB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.local_gas_station,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Last Month\nTheft\n0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 40,
                thickness: 1.5,
              ),
              Text(
                'TRUCK ANALYSIS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.8,
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(7),
                  1: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(children: [
                    Text(
                      "TOTAL",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "ON TRIP",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "IDLE",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    Text(
                      "0",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 80,
                thickness: 1.5,
              ),
              Text(
                'DRIVER ANALYSIS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.8,
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(7),
                  1: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(children: [
                    Text(
                      "TOTAL",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    Text(
                      "5",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "ASSIGNED",
                      style: TextStyle(fontSize: 18, color: Colors.green),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      "UNASSIGNED",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    Text(
                      "1",
                      style: TextStyle(fontSize: 18),
                    ),
                  ]),
                ],
              ),
            ],
          ),
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
