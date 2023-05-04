import 'package:flutter/material.dart';
import 'package:pipe_and_filter/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';

const String apikey = "AIzaSyDJ7bQaVEAWlOGRARK2hKG3oulR-n98uFM";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: apikey,
          authDomain: "pipe-and-filter-game.firebaseapp.com",
          projectId: "pipe-and-filter-game",
          storageBucket: "pipe-and-filter-game.appspot.com",
          messagingSenderId: "952790790140",
          appId: "1:952790790140:web:dcdfe58bde135ea2ee4c79",
          measurementId: "G-Q7FHS5Z951"));
  runApp(const StartScreen());
}
