import 'package:assignments_final/netword/userData/newUser.dart';
import 'package:assignments_final/screens/home/home_srceen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


import '../../../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneUser = TextEditingController();
  final passwordUser = TextEditingController();
  bool isValidatePhone = false;
  bool isValidatePass = false;

  void loginHome(String phone, String pass) async {
    User user = await UserServer().getUser(phone, pass);
    if (user != null) {
      String? token = await FirebaseMessaging.instance.getToken();
      await UserServer().addUserToken(user.id!, token!);
      await Future.delayed(
        Duration(seconds: 1),
        () {
          print(user.idPosts);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user,),));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Icon(
              Icons.lock,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome back, you have been missed!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextField(
                    controller: phoneUser,
                    decoration: InputDecoration(
                      errorText: isValidatePhone
                          ? 'B???n ch??a nh???p s??? ??i???n tho???i'
                          : null,
                      border: InputBorder.none,
                      hintText: "S??? ??i???n tho???i",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: TextField(
                    controller: passwordUser,
                    decoration: InputDecoration(
                      errorText:
                          isValidatePass ? 'B???n ch??a nh???p m???t kh???u' : null,
                      border: InputBorder.none,
                      hintText: "M???t kh???u",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (phoneUser.value.text.length != 10) {
                      isValidatePhone = true;
                    } else {
                      isValidatePhone = false;
                    }
                    if (passwordUser.value.text.length <= 0) {
                      isValidatePass = true;
                    } else {
                      isValidatePass = false;
                    }
                  });
                  loginHome(phoneUser.text, passwordUser.text);

                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                    backgroundColor: Colors.black87),
                autofocus: true,
                child: Text(
                  '????ng nh???p',
                  style: TextStyle(fontSize: 26),
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('You dont have account,'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'signin');
                    },
                    child: Text(
                      'Register now?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
