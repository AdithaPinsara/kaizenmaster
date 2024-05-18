import 'package:kaizenmaster/common/widgets/common_textfield.dart';
import 'package:kaizenmaster/common/widgets/drawer.dart';
import 'package:kaizenmaster/common/widgets/wall_post.dart';
import 'package:kaizenmaster/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  final controller = TextEditingController();

  void postMessage() {
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("user posts").add({
        "UserEmail": currentUser!.email,
        "Message": controller.text,
        "TimeStamp": Timestamp.now(),
        "Likes": [],
      });
    }
    setState(() {
      controller.clear();
    });
  }

  void goToProfile() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyProfilePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Action Wall",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: signOut, icon: Icon(Icons.logout, color: Colors.white))
        ],
      ),
      drawer: CommonDrawer(
        onTapSignOut: signOut,
        onTapprofile: goToProfile,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user posts")
                        .orderBy("TimeStamp", descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.docs[index];
                              return WallPost(
                                message: post["Message"],
                                user: post["UserEmail"],
                                postId: post.id,
                                likes: List<String>.from(post['Likes']) ?? [],
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: CommonTextField(
                    controller: controller,
                    hintText: "Post something...",
                    obscureText: false,
                    readOnly: false,
                  )),
                  IconButton(
                      onPressed: postMessage, icon: Icon(Icons.arrow_outward))
                ],
              ),
            ),
            Text("Logged in as: " + currentUser!.email!),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
