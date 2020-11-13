import 'package:flutter/cupertino.dart';
import 'package:inventory/repository/google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../locator.dart';

enum LoginState { InitialState, LoadedState, LoadingState, ErrorState }

class LoginViewModel with ChangeNotifier {
  LoginState _state;
  FirebaseLogin _firebaseLogin = locator<FirebaseLogin>();
  //_state i get ve set yaptık
  LoginState get state => _state;
  set state(LoginState value) {
    _state = value;
    //Bir atama yaptığımız  için notifyListener koyuyorz.
    notifyListeners();
  }

  LoginViewnModel() {
    state = LoginState.InitialState;
    //Başlangıçta State initiale aldık
  }

  Future<User> signInViewModel(String mail, String password) async {
    User user;
    try {
      state = LoginState.LoadingState;
      print("loading");
      user = await _firebaseLogin.login(mail, password);
      state = LoginState.LoadedState;
    } catch (e) {
      state = LoginState.ErrorState;
    }
    return user;
  }

  Future<void> logOutViewModel() async {
    await _firebaseLogin.logOutRepo();
  }
}
