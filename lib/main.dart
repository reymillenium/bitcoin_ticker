import 'package:bitcoin_ticker/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/price_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoadingScreen(
        title: 'Bitcoin Ticker',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
