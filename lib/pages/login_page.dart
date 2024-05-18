import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaizenmaster/common/widgets/button.dart';
import 'package:kaizenmaster/common/widgets/common_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
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
                    height: 50,
                  ),

                  //welcom back message
                  Text(
                    "Welcome to Kaizen Master",
                    style: TextStyle(fontSize: 20),
                  ),

                  SizedBox(
                    height: 50,
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
                    height: 20,
                  ),

                  //sign in button
                  CommonButton(
                    ontap: signIn,
                    name: "Sign In",
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //go to register page
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?"),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register now",
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
