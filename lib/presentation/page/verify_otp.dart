import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'enter_phone_screen.dart';
import 'register_user.dart';

class VerifyOTP extends StatefulWidget {
  final String verifId;
  final String phoneNum;

  const VerifyOTP({Key? key, required this.verifId, required this.phoneNum})
      : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Changed PopScope to SingleChildScrollView
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              width: 5,
                              color: const Color(0xFF3287BB),
                            ),
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "OTP Verification",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Enter the verification code we just sent to  Number ending with +91 ******${widget.phoneNum.substring(6, 10)}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Pinput(
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    length: 6,
                    controller: _otpController,
                    onChanged: (value) {},
                    defaultPinTheme: PinTheme(
                      textStyle: const TextStyle(fontSize: 25),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF3287BB),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verifId,
                          smsCode: _otpController.text,
                        );
                        await _auth.signInWithCredential(credential);
                        // Future.delayed(Duration(milliseconds: 900), () {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => RegisterUser(
                              phoneNumber: widget.phoneNum,
                            ),
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0),
                                  end:  const Offset(0.0, 0.0),
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                        _otpController.clear();
                      } catch (e) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Caution !'),
                            content: const Text(
                                'The verification code from SMS/TOTP is invalid. \nPlease check and enter the correct verification code again.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xFF3287BB),
                    ),
                    child: Text(
                      "Verify & Continue",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
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
}
