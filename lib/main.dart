import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/category_screen.dart';
import 'package:wallpaper/Screens/splash.dart';
import 'package:wallpaper/myhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDone;
  getSplash()
  {
    Timer(const Duration(milliseconds: 3500),(){
      setState(() {
        isDone=true;
      });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDone=false;
    getSplash();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isDone?MyHomePage():Splash(),
    );
  }
}