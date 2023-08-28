import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_integration/show_post.dart';
import 'package:firebase_integration/utils/utils_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Firebase Post '),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'What is in your mind?'),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: const Color(0xFF085796)),
                  onPressed: () {

                    databaseRef.push().set({

                      'title': postController.text,
                    }).then((value) {
                      Utils().toastMessage('Post Added');
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> PostScreen()));
                    }).onError((error, stackTrace) {

                      Utils().toastMessage('Post Added');
                    });
                  },
                  child: const Text(
                    "Add post",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
