import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assignments_final/model/user.dart';
import 'package:assignments_final/netword/userData/newUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  bool isAdmin = false;
  final passwordReset = TextEditingController();
  File? imageGallery;
  final imagePick = ImagePicker();

  bool isValidatePhone = false;
  bool isValidatePass = false;
  bool isValidateName = false;
  bool isValidateResPass = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back)),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100),
                height: 150,
                width: 150,
                child: GestureDetector(
                  onTap: () => getImageGallery(),
                  child: imageGallery == null
                      ? Image(image: AssetImage('assets/images/logo.png'))
                      : ClipOval(
                          child: Image(
                          image: FileImage(imageGallery!),
                          fit: BoxFit.cover,
                        )),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                        errorText: isValidatePhone
                            ? "Bạn chưa nhập số điện thoại"
                            : null,
                        border: InputBorder.none,
                        hintText: "Số điện thoại",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        errorText: isValidateName ? "Bạn chưa nhập tên" : null,
                        border: InputBorder.none,
                        hintText: "Họ và tên",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        errorText:
                            isValidatePass ? "Bạn chưa nhập mật khẩu" : null,
                        border: InputBorder.none,
                        hintText: "Mật khẩu",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: passwordReset,
                      decoration: InputDecoration(
                        errorText: isValidateResPass
                            ? "Mật khẩu nhập lại không đúng"
                            : null,
                        border: InputBorder.none,
                        hintText: "Nhập lại mật khẩu",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text('Đăng ký quản lý'),
                    CupertinoSwitch(
                      value: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (phone.value.text.length != 10) {
                        isValidatePhone = true;
                      } else {
                        isValidatePhone = false;
                      }
                      if (password.value.text.length <= 0) {
                        isValidatePass = true;
                      } else {
                        isValidatePass = false;
                      }
                      if (name.value.text.length <= 0) {
                        isValidateName = true;
                      } else {
                        isValidateName = false;
                      }
                      if (passwordReset.value.text != password.value.text) {
                        isValidateResPass = true;
                      } else {
                        isValidateResPass = false;
                      }
                    });

                    Uint8List? images = await imageGallery?.readAsBytes();
                    await UserServer().creatAccount(User(
                        id: null,
                        name: name.text,
                        job: isAdmin ? 'true' : 'false',
                        avate: base64.encode(images!),
                        phoneNumber: phone.text,
                        password: password.text,
                        token: null));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 110, vertical: 8)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getImageGallery() async {
    final XFile? image = await imagePick.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageGallery = File(image.path);
      });
    }
  }
}
