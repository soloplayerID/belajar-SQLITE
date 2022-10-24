// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:belajar_sqlite/src/model/profile_model.dart';
import 'package:belajar_sqlite/src/state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

import '../src/presenter/profile_presenter.dart';
import 'fragment/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> implements ProfileState {
  late ProfilePresenter _profilePresenter;
  late ProfileModel _profileModel;
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  final LocalStorage storageLogin = LocalStorage('islogin.json');

  _ProfileState() {
    _profilePresenter = ProfilePresenter();
  }

  @override
  void initState() {
    super.initState();
    _profilePresenter.view = this;
    _profilePresenter.getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileModel.isloading
          ? const Loading()
          : SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edit Profile",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff212121),
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: 130,
                                  height: 130,
                                  padding: const EdgeInsets.all(10),
                                  child: _profileModel.image != ''
                                      ? Container(
                                          child: Image.file(
                                            File(
                                                _profileModel.image.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset('assets/dummy.png')),
                              InkWell(
                                child: const Text('ubah Foto'),
                                onTap: () async {
                                  pickImage();
                                  print('ambil foto');
                                },
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: _profileModel.namaDepan,
                                      decoration: const InputDecoration(
                                          labelText: "nama depan"),
                                      validator: (value) {
                                        if (value != null ||
                                            value!.isNotEmpty) {
                                          final RegExp regex =
                                              RegExp(r"^[a-zA-Z]");
                                          if (!regex.hasMatch(value)) {
                                            return 'Enter a valid name';
                                          } else {
                                            setState(() {
                                              _profileModel.namaDepan.text =
                                                  value;
                                            });
                                            return null;
                                          }
                                        } else {
                                          return 'Enter a valid name';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: TextFormField(
                                      controller: _profileModel.namaBelakang,
                                      decoration: const InputDecoration(
                                          labelText: "nama belakang"),
                                      validator: (value) {
                                        if (value != null ||
                                            value!.isNotEmpty) {
                                          final RegExp regex =
                                              RegExp(r"^[a-zA-Z]");
                                          if (!regex.hasMatch(value)) {
                                            return 'Enter a valid name';
                                          } else {
                                            setState(() {
                                              _profileModel.namaBelakang.text =
                                                  value;
                                            });
                                            return null;
                                          }
                                        } else {
                                          return 'Enter a valid name';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _profileModel.email,
                                decoration:
                                    const InputDecoration(labelText: "email"),
                                validator: (value) {
                                  if (value != null || value!.isNotEmpty) {
                                    final RegExp regex = RegExp(
                                        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                    if (!regex.hasMatch(value)) {
                                      return 'Enter a valid email';
                                    } else {
                                      setState(() {
                                        _profileModel.email.text = value;
                                      });
                                      return null;
                                    }
                                  } else {
                                    return 'Enter a valid email';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _profileModel.phone,
                                decoration:
                                    const InputDecoration(labelText: "Phone"),
                                validator: (value) {
                                  if (value != null || value!.isNotEmpty) {
                                    final RegExp regex =
                                        RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                                    if (!regex.hasMatch(value)) {
                                      return 'Enter a valid Phone';
                                    } else {
                                      setState(() {
                                        _profileModel.phone.text = value;
                                      });
                                      return null;
                                    }
                                  } else {
                                    return 'Enter a valid Phone';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: _profileModel.password,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                ),
                                maxLength: 16,
                                obscureText: true,
                                validator: (value) {
                                  if (value != null || value!.isNotEmpty) {
                                    final RegExp regex = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if (!regex.hasMatch(value)) {
                                      return 'Password must contain an uppercase, lowercase, numeric digit and special character';
                                    } else {
                                      setState(() {
                                        _profileModel.password.text = value;
                                      });
                                      return null;
                                    }
                                  } else {
                                    return 'Password must contain an uppercase, lowercase, numeric digit and special character';
                                  }
                                },
                              ),
                              InkWell(
                                splashColor: const Color(0xff7474BF),
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _profilePresenter.update();
                                  }
                                  // Navigator.pushNamed(context, '/home');
                                  // Fluttertoast.showToast(
                                  //     msg: 'berhasil login :D',
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.BOTTOM,
                                  //     timeInSecForIosWeb: 2,
                                  //     backgroundColor: Colors.green,
                                  //     textColor: Colors.white,
                                  //     fontSize: 15);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 50.0),
                                  height: 43,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 28),
                                            blurRadius: 40,
                                            spreadRadius: -12)
                                      ],
                                      color: Color.fromARGB(255, 39, 199, 124),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await storageLogin.ready;
                                        await storageLogin.setItem(
                                            'isLogin', false);
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/',
                                            (Route<dynamic> route) => false);
                                      },
                                      child: const Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff200391),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.amber,
        textColor: Colors.white,
        fontSize: 15);
  }

  @override
  void onSuccess(String success) {
    Fluttertoast.showToast(
        msg: success,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15);
    Navigator.pop(context);
  }

  @override
  void refreshData(ProfileModel profileModel) {
    setState(() {
      _profileModel = profileModel;
    });
  }

  /// Get from gallery
  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      //supaya tidak fotonya temporary
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final imageTemp = File(pickedFile.path);

// copy the file to a new path
      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(dir, '${_profileModel.namaDepan.text}.jpg');
      File images = imageTemp.renameSync(newPath);
      print(images);
      File newImage = await images
          .copy('${appDirectory.path}/${_profileModel.namaDepan.text}.jpg');
      setState(() {
        _profileModel.image = newImage.path;
        print('filenya ${_profileModel.image}');
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
