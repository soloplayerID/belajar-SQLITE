// ignore_for_file: sized_box_for_whitespace, avoid_print, body_might_complete_normally_nullable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/model/login_model.dart';
import '../src/presenter/login_presenter.dart';
import '../src/state/login_state.dart';
import 'fragment/loading.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginUI();
}

class _LoginUI extends State<Login> implements LoginState {
  late LoginPresenter _loginPresenter;
  late LoginModel _loginModel;
  final formGlobalKey = GlobalKey<FormState>();

  _LoginUI() {
    _loginPresenter = LoginPresenter();
  }

  @override
  void initState() {
    super.initState();
    _loginPresenter.view = this;
    _loginPresenter.loginCheck();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginModel.isloading == true
          ? const Loading()
          : SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: Form(
                  key: formGlobalKey,
                  child: Container(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("test Deptech",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff212121),
                                  fontWeight: FontWeight.bold),
                            )),
                        Text("by Ilham",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 12, color: Color(0xff383838)),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
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
                                        _loginModel.email.text = value;
                                      });
                                      return null;
                                    }
                                  } else {
                                    return 'Enter a valid email';
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                ),
                                maxLength: 16,
                                obscureText: true,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    // final RegExp regex = RegExp(
                                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    // if (!regex.hasMatch(value)) {
                                    //   return 'Enter a valid password';
                                    // } else {
                                    //   return null;
                                    // }
                                    setState(() {
                                      _loginModel.password.text = value;
                                    });
                                    return null;
                                  } else {
                                    return 'Enter a valid password';
                                  }
                                },
                              ),
                              InkWell(
                                splashColor: const Color(0xff7474BF),
                                onTap: () {
                                  if (formGlobalKey.currentState!.validate()) {
                                    _loginPresenter.login();
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
                                      "Masuk",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'belum memiliki akun ? ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, "/signup"),
                                      child: const Text(
                                        'Daftar Sekarang',
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
    print(error);
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
        msg: 'berhasil login :D',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15);
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void refreshData(LoginModel loginModel) {
    setState(() {
      _loginModel = loginModel;
    });
  }

  @override
  void isLogin() {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
