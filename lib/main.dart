import 'package:flutter/material.dart';

import 'login-page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Viet Name Tourism',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Roboto',
      ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viet Name Tourism',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home:Scaffold());
  }
}