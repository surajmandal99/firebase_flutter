import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../screens/login_screen.dart';

class InsertFireStoreScreen extends StatefulWidget {
  const InsertFireStoreScreen({super.key});

  @override
  State<InsertFireStoreScreen> createState() => _InsertFireStoreScreenState();
}

class _InsertFireStoreScreenState extends State<InsertFireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');

  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: const Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String id = DateTime.now().millisecondsSinceEpoch.toString();
          fireStore.doc(id).set({
            'full_name': "asdf", // John Doe
            'company': "adsf", // Stokes and Sons
            'age': 12,
            'id': id
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
