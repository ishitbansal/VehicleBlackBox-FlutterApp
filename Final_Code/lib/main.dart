import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import './pages/login.dart';
import './pages/feed.dart';
import './pages/speech.dart';
import './pages/alerts.dart';
import './pages/map.dart';
import './pages/open.dart';
import './pages/sign.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Black Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: OpenPage(),
      routes: {
        '/open': (context) => OpenPage(),
        '/signup': (context) => SignPage(),
        '/login': (context) => LoginPage(),
        '/feed': (context) => FeedPage(),
        '/speech': (context) => VehiclesPage(),
        '/alerts': (
          context,
        ) =>
            AlertsPage(),
        '/map': (context) => MapPage(),
      },
    );
  }
}
