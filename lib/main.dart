import 'package:flutter/material.dart';
import 'package:kaizenmaster/auth/auth.dart';
import 'package:kaizenmaster/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kaizenmaster/pages/home_page.dart';
import 'package:kaizenmaster/pages/incident_list.dart';
import 'package:kaizenmaster/pages/incident_report.dart';
import 'package:kaizenmaster/pages/organization_reg.dart';
import 'package:kaizenmaster/pages/suggestion_submission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IncidentListScreen(),
    );
  }
}
