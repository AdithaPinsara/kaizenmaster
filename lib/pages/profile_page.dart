import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/common_textbox.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> editField(String field) async {
    String newvalue = '';
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Edit $field',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.grey[900],
            content: TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Enter new $field",
                  hintStyle: TextStyle(color: Colors.grey)),
              onChanged: (value) {
                newvalue = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(newvalue),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
    if (newvalue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newvalue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile Page"),
          backgroundColor: Colors.grey[900],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.person,
                    size: 70,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    currentUser.email ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "My Details",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  CommonTextBox(
                    sectionName: "User Name",
                    text: userData['username'],
                    onPressed: () => editField("username"),
                  ),
                  CommonTextBox(
                    sectionName: "Bio",
                    text: userData['bio'],
                    onPressed: () => editField("bio"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "My posts",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
        // ListView(
        //   children: [
        //     const SizedBox(
        //       height: 40,
        //     ),
        //     Icon(
        //       Icons.person,
        //       size: 70,
        //     ),
        //     const SizedBox(
        //       height: 10,
        //     ),
        //     Text(
        //       currentUser.email ?? "",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(color: Colors.grey[700]),
        //     ),
        //     const SizedBox(
        //       height: 40,
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 10),
        //       child: Text(
        //         "My Details",
        //         style: TextStyle(
        //           color: Colors.grey[600],
        //         ),
        //       ),
        //     ),
        //     CommonTextBox(
        //       sectionName: "User Name",
        //       text: "new user",
        //       onPressed: () => editField("User Name"),
        //     ),
        //     CommonTextBox(
        //       sectionName: "Bio",
        //       text: "new bio",
        //       onPressed: () => editField("Bio"),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 10),
        //       child: Text(
        //         "My posts",
        //         style: TextStyle(
        //           color: Colors.grey[600],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
