import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/button.dart';
import 'package:kaizenmaster/common/widgets/common_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match!");
      return;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email)
          .set(
              {'username': emailController.text.split('@')[0], 'bio': "Empty"});

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  //logo
                  Icon(
                    Icons.analytics_rounded,
                    size: 100,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Welcome to Kaizen Master",
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  //welcom back message
                  Text("Create a new account"),

                  SizedBox(
                    height: 20,
                  ),

                  //email textField
                  CommonTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                    readOnly: false,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //password textField
                  CommonTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    readOnly: false,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //password textField
                  CommonTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    readOnly: false,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //sign in button
                  CommonButton(
                    ontap: signUp,
                    name: "Sign Up",
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
