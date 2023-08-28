import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/dashboard_screen.dart';
import 'package:firebase_integration/utils/utils_class.dart';

import 'package:flutter/material.dart';

import '../enter_phone_no/enter_phone_no.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  void LoginValidation(){
    if(emailController.text.isEmpty){
      Utils().toastMessage('Please Enter Email');
    }else    if(passwordController.text.isEmpty){
      Utils().toastMessage('Please Enter Password');
    }

    auth
        .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      Navigator.push(context,MaterialPageRoute(builder: (context)=> const DashboardScreen()));
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
    });
        /*.catchError((e) {
      Utils().toastMessage(e.toString());
      print("error- "+e.toString());
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Login Here',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 80,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter E-mail'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Password'),
            ),
            const SizedBox(
              height: 30,
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
                    LoginValidation();

                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have account?',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF535353)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Create Account',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFEE812D)),
                )
              ],
            ),
            const SizedBox(
              height: 30,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterPhoneScreen()));
                  },
                  child: const Text(
                    "Login with phone",
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

  void fetchUserInfo(String id) async {}
}
