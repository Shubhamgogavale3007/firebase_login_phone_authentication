import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/dashboard_screen.dart';
import 'package:firebase_integration/login_screen/login_screen.dart';
import 'package:firebase_integration/utils/utils_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
class OtpScreen extends StatefulWidget {
  final String verificationID;
  const OtpScreen({super.key, required this.verificationID});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color(0xFFE0F1FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFE0F1FF),
        elevation: 0,
        leadingWidth: 90,
        leading: InkWell(
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF8FAFC),
            radius: 30,
            child:Icon(Icons.arrow_back_ios_new)
          ),
          onTap: (){
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
              'Enter Your OTP',
              style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF085796)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please enter verification code sent to',
              style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF535353)),
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  controller: phoneController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    height: 45,
                    width: 45,
                    textStyle: const TextStyle(fontSize: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFDADADA),width: 2),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                  ),

                  pinAnimationType: PinAnimationType.slide,
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());

                    }
                  },
                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: const Color(0xFF085796)),
                  onPressed: () async {
                    final credentials = PhoneAuthProvider.credential(
                        verificationId: widget.verificationID, smsCode: phoneController.text.toString());

                 try{
                      await auth.signInWithCredential(credentials);
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> DashboardScreen()));
                 }
                     catch(e){
                   Utils().toastMessage(e.toString());
                     }
                  },
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn’t receive the code?',
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
                  'Resend',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFEE812D)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
