import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tut/ui/auth/posts/add_post.dart';
import 'package:firebase_tut/ui/auth/screens/login_screen.dart';
import 'package:firebase_tut/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref("Post");
    var searchFilter = TextEditingController();

    // void initState() {m
    //   super.initState();
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Post"),
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
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                  hintText: "Search", border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),

          //USING STREAMBUILDER FOR FETCHING THE DATA FROM THE DATABASE IN ASYNC MANNER
          // Expanded(
          //     child: StreamBuilder(
          //         stream: ref.onValue,
          //         builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //           if (!snapshot.hasData) {
          //             return const Center(
          //               child: CircularProgressIndicator(),
          //             );
          //           } else {
          //             Map<dynamic, dynamic> map =
          //                 snapshot.data!.snapshot.value as dynamic;
          //             List<dynamic> list = [];
          //             list.clear();
          //             list = map.values.toList();
          //             return ListView.builder(
          //               itemCount: list.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: Text(list[index]['title']),
          //                   subtitle: Text(list[index]['id']),
          //                 );
          //               },
          //             );
          //           }
          //         })),

          // USING FIREBASE ANIMATED LIST FOR FETCHING THE DATA FROM THE DATABASE IN ASYNC MANNER
          Expanded(
              child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              final title = snapshot.child("title").value.toString();

              if (searchFilter.text.isEmpty) {
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle: Text(snapshot.child("id").value.toString()),
                );
              } else if (title
                  .toLowerCase()
                  .contains(searchFilter.text.toLowerCase().toString())) {
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle: Text(snapshot.child("id").value.toString()),
                );
              } else {
                return Container();
              }
              // return ListTile(
              //   title: Text(snapshot.child("title").value.toString()),
              //   subtitle: Text(snapshot.child("id").value.toString()),
              // );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
