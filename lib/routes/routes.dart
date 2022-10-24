import 'package:belajar_sqlite/screen/home.dart';
import 'package:belajar_sqlite/screen/signup.dart';
import 'package:flutter/material.dart';

import '../screen/login.dart';

final routes = {
  '/': (BuildContext context) => const Login(),
  '/signup': (BuildContext context) => const SignUpScreen(),
  '/home': (BuildContext context) => const HomePage(),
};
