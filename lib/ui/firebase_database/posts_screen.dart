import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../auth/posts/add_post.dart';
import '../auth/screens/login_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');

  @override
  void initState() {
    // TODO: implement initState
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
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                        color: Colors.grey,
                        elevation: 4,
                        padding: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        icon: const Icon(
                          Icons.more_vert,
                        ),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);

                                      ref
                                          .child(snapshot
                                              .child('id')
                                              .value
                                              .toString())
                                          .update({'title': 'nice world'})
                                          .then((value) {})
                                          .onError((error, stackTrace) {
                                            Utils()
                                                .toastMessage(error.toString());
                                          });
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);

                                    // ref.child(snapshot.child('id').value.toString()).update(
                                    //     {
                                    //       'ttitle' : 'hello world'
                                    //     }).then((value){
                                    //
                                    // }).onError((error, stackTrace){
                                    //   Utils().toastMessage(error.toString());
                                    // });
                                    ref
                                        .child(snapshot
                                            .child('id')
                                            .value
                                            .toString())
                                        .remove()
                                        .then((value) {})
                                        .onError((error, stackTrace) {
                                      Utils().toastMessage(error.toString());
                                    });
                                  },
                                  leading: const Icon(Icons.delete_outline),
                                  title: const Text('Delete'),
                                ),
                              ),
                            ]),
                  );
                }),
          ),
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
