import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/button.dart';
import 'package:kaizenmaster/pages/home_page.dart';
import 'package:kaizenmaster/pages/incident_report.dart';
import 'package:kaizenmaster/pages/suggestion_submission.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kaizen Master",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: signOut, icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonButton(
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IncidentReportPage();
                }));
              },
              name: "Incident report",
            ),
            CommonButton(
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SuggestionSubmissionPage();
                }));
              },
              name: "Suggestion Submission",
            ),
            CommonButton(
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              name: "Action Wall",
            ),
          ],
        ),
      ),
    );
  }
}
