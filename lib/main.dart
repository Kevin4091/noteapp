import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/view/splashscreen/splashscreen.dart';

Future<void> main() async {
  // HIVE step 2
  await Hive.initFlutter();
  // HIVE step 3
  var box = await Hive.openBox('noteBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
