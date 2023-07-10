import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Vehicle Black Box';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: MyStatefulWidget(),
        debugShowCheckedModeBanner: false);
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

final FlutterTts tts = FlutterTts();
speak(String text) async {
  await tts.setLanguage('en-US');
  await tts.speak(text);
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    speak('Your monthly fuel theft is 40 litres and weekly fuel theft is 30 litres');
    return Scaffold(
      body: Center(
          child:
           SizedBox(
        width: 500,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(children: [  
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.account_circle, size: 200)),
                Text('shivam\nshivam@cyrrup.com\n+91 9898888823')
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      height: 150,
                      color: Color.fromARGB(255, 230, 223, 223),
                      child: Row(children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.local_gas_station,
                              color: Color.fromARGB(255, 242, 5, 5), size: 50),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Last Week Theft\n30'),
                        ),
                      ])),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 200,
                      height: 150,
                      color: Color.fromARGB(255, 230, 223, 223),
                      child: Row(children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.local_gas_station,
                              color: Color.fromARGB(255, 242, 5, 5), size: 50),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Last Month Theft\n40'),
                        ),
                      ])),
                ),
              ],
            ),
            TruckAnalysis(),
            DriverAnalysis(),
          ]),
        ),
      )),
    );
  }
}

class TruckAnalysis extends StatelessWidget {
  const TruckAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 150,
        child: Column(
          children: [
            Text('TRUCK ANALYSIS',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(color: Colors.black),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(9),
                1: FlexColumnWidth(1),
              },
              children: const [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("TOTAL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("4"),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:
                        Text("ON TRIP", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("4"),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("IDLE", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("0"),
                  ),
                ]),
              ],
            ),
          ],
        ));
    // );
  }
}

class DriverAnalysis extends StatelessWidget {
  const DriverAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 150,
        child: Column(
          children: [
            Text('DRIVER ANALYSIS',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(color: Colors.black),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(9),
                1: FlexColumnWidth(1),
              },
              children: const [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("TOTAL", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("5"),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:
                        Text("ASSIGNED", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("4"),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child:
                        Text("UNASSIGNED", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("1"),
                  ),
                ]),
              ],
            ),
          ],
        ));
    // );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Text(
      'Maps',
      style: optionStyle,
    ),
    Text(
      'Vehicles',
      style: optionStyle,
    ),
    Text(
      'Alerts',
      style: optionStyle,
    ),
    Text(
      'Geofence',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Black Box'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Geofence',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
