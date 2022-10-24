import 'dart:io';

import 'package:flutter/material.dart';

class ProfileModel {
  bool isloading = false;
  bool isSuccess = false;
  String? image;
  final TextEditingController email = TextEditingController();
  final TextEditingController namaDepan = TextEditingController();
  final TextEditingController namaBelakang = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
}
