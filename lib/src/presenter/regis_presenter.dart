import 'dart:convert';

import 'package:belajar_sqlite/src/model/regis_model.dart';
import 'package:belajar_sqlite/src/state/regis_state.dart';
import 'package:localstorage/localstorage.dart';

abstract class RegisPresenterAbstract {
  set view(RegisState view) {}
  void register() {}
}

class RegisPresenter implements RegisPresenterAbstract {
  final RegisModel _regisModel = RegisModel();
  late RegisState _regisState;
  final LocalStorage storage = LocalStorage('register.json');

  @override
  set view(RegisState view) {
    _regisState = view;
    _regisState.refreshData(_regisModel);
  }

  @override
  void register() async {
    _regisModel.isSuccess = true;
    _regisState.refreshData(_regisModel);

    //nyimpen daata ke local storaage, bukan ke sqlLite
    final info = json.encode({
      'namaDepan': _regisModel.namaDepan.text,
      'namaBelakang': _regisModel.namaBelakang.text,
      'email': _regisModel.email.text,
      'phone': _regisModel.phone.text,
      'password': _regisModel.password.text,
      'image': '',
    });
    await storage.setItem('data_regis', info);

    _regisModel.isSuccess = false;
    _regisState.refreshData(_regisModel);
    _regisState.onSuccess('berhasil register, silahkan login');
  }
}
