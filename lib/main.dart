import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kansizlik/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
