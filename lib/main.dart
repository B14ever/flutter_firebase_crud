import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app.dart';
import 'injection_container.dart' as dependency_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();
  runApp(const MyApp());
}
