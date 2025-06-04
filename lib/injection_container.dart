import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';


final serviceLocator = GetIt.instance;
Future<void> init() async {
  await Firebase.initializeApp();
}
