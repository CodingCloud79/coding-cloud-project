import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/page/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'verify_otp.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String smsCode = "";
  RegExp phoneValid = RegExp(r"^\+?[0-9]{10,12}$");

  bool validatePhoneNumber(String phone) {
    String phoneNumber = phone.trim();
    return phoneValid.hasMatch(phoneNumber);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Animate(
          effects: const [
            SlideEffect(
              duration: Duration(milliseconds: 500),
            )
          ],
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.6],
                colors: [
                  Color(0xFF8AD9FF),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/OTP_img.png'),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter Your Mobile Number",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                Text(
                  "We will send you the 6 digit verification code ",
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          controller: _phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Phone Number';
                            } else {
                              bool res = validatePhoneNumber(value);
                              if (res) {
                                return null;
                              } else {
                                return "Enter Correct Phone Number";
                              }
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Mobile Number ",
                            hintStyle: TextStyle(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide(
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3287BB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _verifyPhoneNumber(_phoneController.text);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account ? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text("Login "))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyPhoneNumber(String phone) async {
    debugPrint("verify Phone Called ");
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${_phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          await _auth.signInWithCredential(authCredential).then((value) {
            debugPrint("verificationCompleted...");
          });
        },
        verificationFailed: (error) {
          setState(() {
            isLoading = false;
          });
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Error !'),
              content: const Text('Enter Correct Phone Number '),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          debugPrint(" Code Received ");
          debugPrint(
              " Phone Number from Phone Screen \n" + _phoneController.text);
          setState(() {
            isLoading = false;
          });

          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => VerifyOTP(
                verifId: verificationId,
                phoneNum: _phoneController.text,
              ),
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
          // Navigator.pop();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException caught:');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
    } catch (e) {
      debugPrint("$e");
    }
  }
}
