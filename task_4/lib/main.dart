// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         title: Center(child: Text('Hello World')),
//         backgroundColor: Colors.blueGrey[600],
//       ),
//     ),
//   ));
// }
import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/feed.dart';
import './pages/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Black Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/feed': (context) => FeedPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.toString().split('/');

        if (pathElements[0] != '') {
          return null;
        }

        switch (pathElements[1]) {
          case 'detailId':
            final String detailId = pathElements[2];

            print("DetailId: $detailId");

            if (detailId.isEmpty) {
              return MaterialPageRoute(
                builder: (BuildContext context) => DetailPage("No Detail"),
              );
            }

            String itemName = "Item Detail: $detailId";

            return MaterialPageRoute(
              builder: (BuildContext context) => DetailPage(itemName),
            );
          default:
            return null;
        }
      },
    );
  }
}
