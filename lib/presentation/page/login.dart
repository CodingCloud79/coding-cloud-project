import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/page/tabs/home_screen_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RegExp phoneValid = RegExp(r"^\+?[0-9]{10,12}$");
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool validatePhoneNumber(String phone) {
    String phoneNumber = phone.trim();
    return phoneValid.hasMatch(phoneNumber);
  }

  bool isValidPassword(String pass) {
    final passRegex = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    return passRegex.hasMatch(pass);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Login "),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF8AD9FF),
          ),
        ),
      ),
      body: Container(
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                enableSuggestions: true,
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
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
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Passwoord';
                  } else {
                    bool res = isValidPassword(value);
                    if (res) {
                      return null;
                    } else {
                      return "Enter Correct Password";
                    }
                  }
                },
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter Password ",
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
              SizedBox(
                height: 20,
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
                      login();
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    // QuerySnapshot snapshotS = await FirebaseFirestore.instance
    //     .collection('users')
    //     .where('phone', isEqualTo: _phoneController.text)
    //     .get();
    // var userDocId = snapshotS.docs[0].id;
    // print(userDocId);
    // var collection =
    //     FirebaseFirestore.instance.collection('users').doc(userDocId);
    // var data = await collection.get();
    // print(data.data());
    final snapshot = await checkCredentials();
    if (snapshot.docs.isNotEmpty) {
      debugPrint("Snapshot is Not Empty");
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print(" Snapshot $data");
        String password = data['password'];

        if (_passwordController.text != password) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Password Not matched !',
              ),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('loggedIn', true);
          debugPrint("Logged In");
          await prefs.setString('profile', "user");
          await prefs.setString('uuid', data['uuid']);
          await prefs.setString('name', data['name']);
          await prefs.setString('phone', data['phone']);
          await prefs.setString('profileUrl', data['profileUrl']);
          await prefs.setString('refferID', data['refferalID']);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone Number does not exist !'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<QuerySnapshot> checkCredentials() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', isEqualTo: _phoneController.text)
        .get();
    print("Check Credential();");
    return snapshot;
  }
}
