import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'src/screens/input_screen.dart';
import 'src/screens/report_screen.dart';
import 'shared/widgets/debug_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Connect to Firebase Emulator Suite only in debug mode
  if (kDebugMode) {
    try {
      final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';

      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
      FirebaseAuth.instance.useAuthEmulator(host, 9099);

      // Optional: set emulator settings for Cloud Storage etc.

      // Log success
      // ignore: avoid_print
      print('✅ Firebase Emulators connected: $host');
    } catch (e) {
      // ignore: avoid_print
      print('🛑 Error connecting to Firebase Emulators: $e');
    }
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIBaZi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Wrap main content with DebugOverlay so metadata is visible in debug mode
      home: const DebugOverlay(
        child: InputScreen(),
      ),
      routes: {
        '/report': (context) => const ReportScreen(),
      },
    );
  }
}