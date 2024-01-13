import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/utils/utils.dart';
import 'package:firebase_tut/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
        ),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(
                hintText: "Enter Your Email", border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: RoundButton(
            onTap: () {
              _auth
                  .sendPasswordResetEmail(
                      email: emailController.text.toString())
                  .then((value) {
                Utils().toastMessage(
                    "We have sent email to recover password,please check yoour email");
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            title: 'Forget',
          ),
        ),
      ]),
    );
  }
}
