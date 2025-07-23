import 'dart:developer';

import 'package:aithena/data/db/db.dart';
import 'package:aithena/screens/home.page.dart';
import 'package:aithena/screens/login.page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   try {
  
    await HiveService().init("@AUTH");


  } catch (e) {
    log("Hive initialization failed: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ggc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HiveService().getData("user", "@AUTH")?['token'] == null? LoginPage() : DashboardScreen(),
    );
  }
}

