import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/page/activate_membership.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/register_screen_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUser extends StatefulWidget {
  final String phoneNumber;
  const RegisterUser({super.key, required this.phoneNumber});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

final List<String> education = [
  "Diploma",
  "B.A",
  "BBA",
  "BCA",
  "B.Tech",
  "B.Sc",
  "MCA",
  "MBA",
  "M.Tech",
];
List<String> years = List.generate(25, (index) => (2000 + index).toString());
bool uploading = false;

class _RegisterUserState extends State<RegisterUser> {
  late String phoneNum;
  @override
  void initState() {
    super.initState();
    setState(() {
      phoneNum = widget.phoneNumber;
      debugPrint(" Phone Number $phoneNum");
    });
  }

  File? _selectedImage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passoutYearController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedEducation = education.first;
  String? _selectedPassOutYear = years.first;
  String? profileUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    heading(32, "Complete your profile ", FontWeight.w700),
                    const SizedBox(
                      height: 10,
                    ),
                    heading(24, "Activate You Membership  ", FontWeight.w400),
                    const SizedBox(
                      height: 30,
                    ),
                    _selectPassportPhoto(),
                    const SizedBox(
                      height: 30,
                    ),
                    tff("Name", TextInputType.name, _nameController, "Name",
                        "Please Enter Name "),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomeDropdownMenu(
                          label: "Education",
                          items: education,
                          controller: _educationController,
                          errortext: "Select Education",
                          initialValue: education.first,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedEducation = value!;
                              debugPrint(_selectedEducation);
                            });
                          },
                        ),
                        CustomeDropdownMenu(
                          label: "Passout Year",
                          items: years,
                          controller: _passoutYearController,
                          initialValue: years.first,
                          errortext: "Select Year",
                          onChanged: (String? value) {
                            setState(() {
                              _selectedPassOutYear = value!;
                              debugPrint(_selectedPassOutYear);
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    tff("Email", TextInputType.emailAddress, _emailController,
                        "Email", "Enter Correct Email "),
                    const SizedBox(
                      height: 25,
                    ),
                    tff("City", TextInputType.streetAddress, _cityController,
                        "City", " Enter City ")
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color(0xFF3287BB),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedImage == null) {
                        showDialog(
                          context: context,
                          builder: ((context) => AlertDialog(
                                title: const Text("Select Profile Photo "),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  )
                                ],
                              )),
                        );
                      } else {
                        var uuid = const Uuid().v4();
                        uploadProfile(uuid);
                      }
                    }
                  },
                  child: const Text(
                    " Submit ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectPassportPhoto() {
    if (_selectedImage != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(65)),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: 130,
                height: 130,
              ),
            ),
            Opacity(
              opacity: uploading ? 1 : 0,
              child: const SizedBox(
                height: 130,
                width: 130,
                child: CircularProgressIndicator(),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    color: const Color(0xFF3287BB),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        height: 120,
        width: 120,
        child: IconButton(
          icon: const Icon(
            Icons.add_a_photo,
            size: 60,
            color: Color(0xFF3287BB),
          ),
          onPressed: _pickImageFromGallery,
        ),
      );
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> uploadProfile(String uuid) async {
    try {
      setState(() {
        uploading = true;
      });
      var firebaseStorage = FirebaseStorage.instance.ref('userProfiles/$uuid');
      UploadTask uploadTask = firebaseStorage.putFile(
          _selectedImage!, SettableMetadata(contentType: 'image/jpg'));
      await uploadTask;
      String downloadURL = await firebaseStorage.getDownloadURL();
      profileUrl = downloadURL;
      setState(() {
        uploading = false;
      });
      debugPrint("Download URL: $downloadURL");
      uploadData(downloadURL, uuid);
    } catch (error) {
      debugPrint("Firebase Storage Error: $error");
    }
  }

  Future<void> uploadData(String url, String uuid) async {
    FirebaseFirestore.instance.collection('users').add({
      'name': _nameController.text,
      'education': _selectedEducation,
      'passoutYear': _selectedPassOutYear,
      'email': _emailController.text,
      'city': _cityController.text,
      'phone': phoneNum,
      'profileUrl': url,
      'uuid': uuid
    });
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActivateMembership(),
      ),
    );
  }
}
