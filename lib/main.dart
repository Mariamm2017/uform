import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'RealTimeDatabase CRUD/real_tim_crud.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Realtime Database',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: RealTimeCRUDEdatabase(),
    );
  }
}
