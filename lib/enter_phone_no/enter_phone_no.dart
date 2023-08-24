import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/otp_screen/otp_screen.dart';
import 'package:firebase_integration/utils/utils_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFE0F1FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFE0F1FF),
        elevation: 0,
        leadingWidth: 90,
        leading: InkWell(
          child: CircleAvatar(
              backgroundColor: const Color(0xFFF8FAFC),
              radius: 30,
              child: Icon(Icons.arrow_back_ios_new)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Enter Phone Number',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefix: Padding(
                  padding:  EdgeInsets.only(right: 10),
                  child: Text('+91'),
                ),
                border: OutlineInputBorder(),
                hintText: 'Enter 10 digit number',
                counterText: "",
              ),
            ),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor:  Color(0xFF085796)),
                  onPressed: () {
                    String number = '+91${phoneController.text}';
                    if(phoneController.text.isEmpty){
                      Utils().toastMessage('Enter Phone Number');
                    }


                    auth.verifyPhoneNumber(

                        phoneNumber: number,
                        verificationCompleted: (_) {},
                        verificationFailed: (e) {
                          Utils().toastMessage(e.toString());
                        },
                        codeSent: (String verificationId, int? token) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtpScreen(
                                        verificationID: verificationId,
                                      )));
                        },
                        codeAutoRetrievalTimeout: (e) {
                       Utils().toastMessage(e);

                        });
                  },
                  child:  Text(
                    "Submit",
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
