// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import '../model/profile_model.dart';
import '../state/profile_state.dart';

abstract class ProfilePresenterAbstract {
  set view(ProfileState view) {}
  void getData() {}
  void update() {}
}

class ProfilePresenter implements ProfilePresenterAbstract {
  final ProfileModel _profileModel = ProfileModel();
  late ProfileState _profileState;
  final LocalStorage storage = LocalStorage('register.json');

  @override
  set view(ProfileState view) {
    _profileState = view;
    _profileState.refreshData(_profileModel);
  }

  @override
  void getData() async {
    _profileModel.isloading = true;
    _profileState.refreshData(_profileModel);
    await storage.ready;
    if (await storage.getItem('data_regis') != null) {
      Map<String, dynamic> info =
          json.decode(await storage.getItem('data_regis'));
      _profileModel.email.text = info['email'];
      _profileModel.namaDepan.text = info['namaDepan'];
      _profileModel.namaBelakang.text = info['namaBelakang'];
      _profileModel.phone.text = info['phone'];
      _profileModel.password.text = info['password'];
      _profileModel.image = info['image'];
      _profileModel.isloading = false;
      _profileState.refreshData(_profileModel);
    } else {
      _profileModel.isloading = false;
      _profileState.refreshData(_profileModel);
    }
  }

  @override
  void update() async {
    _profileModel.isloading = true;
    _profileState.refreshData(_profileModel);

    final info = json.encode({
      'namaDepan': _profileModel.namaDepan.text,
      'namaBelakang': _profileModel.namaBelakang.text,
      'email': _profileModel.email.text,
      'phone': _profileModel.phone.text,
      'password': _profileModel.password.text,
      'image': _profileModel.image,
    });
    await storage.setItem('data_regis', info);
    _profileModel.isloading = true;
    _profileState.refreshData(_profileModel);
    _profileState.onSuccess('data berhasil di update 🔥');
  }
}
