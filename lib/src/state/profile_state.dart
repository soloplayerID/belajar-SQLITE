import '../model/profile_model.dart';

abstract class ProfileState {
  void refreshData(ProfileModel profileModel);
  void onSuccess(String success);
  void onError(String error);
}
