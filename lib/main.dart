import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/homeScreen.dart';
import './models/gifAPI.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contxt) => Gify(),
      child: MaterialApp(
        title: "GIF SEARCH",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: GIF(),
      ),
    );
  }
}

class GIF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(),
    );
  }
}

void main() => runApp(MyApp());
