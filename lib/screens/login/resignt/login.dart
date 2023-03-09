import 'package:assignments_final/netword/userData/newUser.dart';
import 'package:assignments_final/netword/viewModel/loginViewModel.dart';
import 'package:assignments_final/screens/home/home_srceen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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

  @override
  void initState() {
    // TODO: implement initState
    context.watch<LoginViewModel>();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginViewModel>();

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
                          ? 'Bạn chưa nhập số điện thoại'
                          : null,
                      border: InputBorder.none,
                      hintText: "Số điện thoại",
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
                      isValidatePass ? 'Bạn chưa nhập mật khẩu' : null,
                      border: InputBorder.none,
                      hintText: "Mật khẩu",
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

                  // login view model
                  user.loginGetData(phoneUser.text, passwordUser.text);
                  user.user == "null" ? SnackBar(
                      content: Text('Tài khoản không tồn tại')) : Navigator
                      .pushReplacement(
                      context, MaterialPageRoute(
                    builder: (context) => Home(user: user.user!),));
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                    backgroundColor: Colors.black87),
                autofocus: true,
                child: Text(
                  'Đăng nhập',
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
