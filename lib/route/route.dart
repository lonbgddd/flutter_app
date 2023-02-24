import 'package:assignments_final/screens/home/home_srceen.dart';
import 'package:assignments_final/screens/login/resignt/login.dart';
import 'package:assignments_final/screens/login/signin/signin.dart';
import 'package:fluro/fluro.dart';

import '../screens/splash/splashSrceen.dart';

class RouterFluro {
  static FluroRouter router = FluroRouter();
  static var screenLoginHandler = Handler(
    handlerFunc: (context, parameters) => LoginScreen(),
  );
  static var screenSplash = Handler(
    handlerFunc: (context, parameters) => SplashSrceen(),
  );
  static var screenSignInHandler = Handler(
    handlerFunc: (context, parameters) => SignIn(),
  );
  static var screenhomeHandler = Handler(
    handlerFunc: (context, parameters) => SignIn(),
  );

  static initRouter() {
    router.define("login", handler: screenLoginHandler);
    router.define("signin", handler: screenSignInHandler);
    router.define('/', handler: screenSplash);
  }
}
