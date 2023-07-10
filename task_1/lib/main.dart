import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Hello World App"),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: Container(
            child: Column(children: [
          Container(
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(""),
                            content: const Text("Hello World"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(10),
                                  child: const Text("OK"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text("Click Me!")))),
          Container(
              child: Center(child: Image(image: AssetImage('images/car.jpg'))))
        ])));
  }
}
