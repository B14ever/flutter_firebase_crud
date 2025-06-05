
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/app.dart';
import 'injection_container.dart' as dependencies_injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependencies_injection.init(); // Initialize dependencies
    try {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
      print("Signed in anonymously.");
    } else {
      print("Already signed in: ${FirebaseAuth.instance.currentUser!.uid}");
    }
  } catch (e) {
    print("Error signing in anonymously: $e");
  }
  runApp(const MyApp());
}
