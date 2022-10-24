import 'package:belajar_sqlite/screen/fragment/loading.dart';
import 'package:belajar_sqlite/src/model/regis_model.dart';
import 'package:belajar_sqlite/src/presenter/regis_presenter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/state/regis_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> implements RegisState {
  late RegisPresenter _regisPresenter;
  late RegisModel _regisModel;
  final _formKey = GlobalKey<FormState>();

  _SignUpScreenState() {
    _regisPresenter = RegisPresenter();
  }

  @override
  void initState() {
    super.initState();
    _regisPresenter.view = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _regisModel.isloading
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
                        Text("Register",
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
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
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
                                              _regisModel.namaDepan.text =
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
                                              _regisModel.namaBelakang.text =
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
                                        _regisModel.email.text = value;
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
                                        _regisModel.phone.text = value;
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
                                        _regisModel.password.text = value;
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
                                    _regisPresenter.register();
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
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 40,
                              // ),
                              // Center(
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       const Text(
                              //         'Sudah punya akun ? ',
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.w600,
                              //             color: Colors.grey),
                              //       ),
                              //       InkWell(
                              //         onTap: () => Navigator.pushNamed(context, "/"),
                              //         child: const Text(
                              //           'Login',
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.w600,
                              //             color: Color(0xff200391),
                              //           ),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // )
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
  void refreshData(RegisModel regisModel) {
    setState(() {
      _regisModel = regisModel;
    });
  }
}
