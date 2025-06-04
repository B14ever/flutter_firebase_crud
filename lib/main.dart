
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app.dart';
import 'injection_container.dart' as dependencies_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependencies_injection.init(); // Initialize dependencies
  
  runApp(const MyApp());
}
