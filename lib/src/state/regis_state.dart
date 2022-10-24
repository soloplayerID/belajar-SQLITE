import '../model/regis_model.dart';

abstract class RegisState {
  void refreshData(RegisModel regisModel);
  void onSuccess(String success);
  void onError(String error);
}
