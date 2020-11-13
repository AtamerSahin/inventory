import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> login(String mail, String password) async {
    var authResult =
        await _auth.signInWithEmailAndPassword(email: mail, password: password);
    User user = authResult.user;
    return user;
  }

  Future<void> logOutRepo() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
      print("Çıkış Başarılı");
    } else {
      return null;
    }
  }
}
