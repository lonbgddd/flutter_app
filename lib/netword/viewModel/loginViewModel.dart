import 'package:flutter/cupertino.dart';

import '../../model/user.dart';
import '../userData/newUser.dart';

class LoginViewModel with ChangeNotifier {
  User? user;

  Future<dynamic> loginGetData(String phone, String pass) async {
    try {
      user = await UserServer().getUser(phone, pass);
      return user ?? "null";
    } catch (e) {
      throw Exception(e);
    }
  }
}
