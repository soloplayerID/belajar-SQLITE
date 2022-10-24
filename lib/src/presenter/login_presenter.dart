// ignore_for_file: avoid_print

import 'dart:convert';

import '../model/login_model.dart';
import '../state/login_state.dart';
import 'package:localstorage/localstorage.dart';

abstract class LoginPresenterAbstract {
  set view(LoginState view) {}
  void login() {}
  void loginCheck() {}
}

class LoginPresenter implements LoginPresenterAbstract {
  final LoginModel _loginModel = LoginModel();
  late LoginState _loginState;
  final LocalStorage storage = LocalStorage('register.json');
  final LocalStorage storageLogin = LocalStorage('islogin.json');

  @override
  set view(LoginState view) {
    _loginState = view;
    _loginState.refreshData(_loginModel);
  }

  @override
  void loginCheck() async {
    _loginModel.isloading = true;
    _loginState.refreshData(_loginModel);
    await storageLogin.ready;
    if (await storageLogin.getItem('isLogin') != false) {
      print('islogin !');
      print('dataLogin: ${await storage.getItem('data_regis')}');
      _loginModel.isloading = false;
      _loginState.refreshData(_loginModel);
      _loginState.isLogin();
    } else {
      _loginModel.isloading = false;
      _loginState.refreshData(_loginModel);
      _loginState.onError('Silahkan Login');
    }
  }

  @override
  void login() async {
    _loginModel.isloading = true;
    _loginState.refreshData(_loginModel);
    //sedaang loading

    await storage.ready;
    await storageLogin.ready;
    print('data=: ${await storage.getItem('data_regis')}');
    if (await storage.getItem('data_regis') != null) {
      Map<String, dynamic> info =
          json.decode(await storage.getItem('data_regis'));
      print(info['email']);
      print(info['name']);
      print(info['phone']);
      if (info['email'] == _loginModel.email.text &&
          info['password'] == _loginModel.password.text) {
        _loginModel.isloading = false;
        _loginState.refreshData(_loginModel);
        _loginState.onSuccess('YEY Berhasil Login! :D');
        storageLogin.setItem('isLogin', true);
      } else {
        _loginModel.isloading = false;
        _loginState.refreshData(_loginModel);
        _loginState.onError('email atau password salah! xD');
      }
    } else {
      _loginModel.isloading = false;
      storageLogin.setItem('isLogin', false);
      _loginState.refreshData(_loginModel);
      _loginState.onError('Regis dulu');
    }
  }
}
