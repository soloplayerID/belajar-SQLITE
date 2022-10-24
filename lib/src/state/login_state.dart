import '../model/login_model.dart';

abstract class LoginState {
  void refreshData(LoginModel loginModel);
  void onSuccess(String success);
  void onError(String error);
  void isLogin();
}
