import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  TextEditingController searchController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final refs = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: searchController,
              onChanged: (value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Search items, collections ...',
                  prefixIcon: Icon(
                    Icons.search,

                  )),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: refs,
                  itemBuilder: (
                    context,
                    snapshot,
                    animation,
                    index,
                  ) {
                    String title = snapshot.child('title').value.toString();

                    if(searchController.text.isEmpty){
                      return ListTile(

                        title: Text(snapshot.child('title').value.toString()),
                      );
                    }else if(title.toLowerCase().toString().contains(searchController.text.toLowerCase().toString())){
                      return ListTile(

                        title: Text(snapshot.child('title').value.toString()),
                      );
                    }
                    else{
                      return Container();
                    }

                  }),
            )
          ],
        ),
      ),
    );
  }
}
