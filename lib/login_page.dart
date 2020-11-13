import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'view_models/google_auth_view_models..dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var _fkey = GlobalKey<FormState>();
  var _sKey = GlobalKey<ScaffoldState>();
  var _mailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, LoginViewModel _loginViewmodel, widget) => Scaffold(
        key: _sKey,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 110, right: 110),
            child: Center(
              child: Form(
                  key: _fkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 180,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://ph-files.imgix.net/6f3ef1a1-f383-401e-898b-0e82b56563f3?auto=format"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        TextFormField(
                          controller: _mailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Mail Adresini Giriniz",
                            hintText: "e-Mail",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (s) {
                            if (s.length < 15) {
                              return "15 Karakterden Kısa Olamaz";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: "Şifrenizi Giriniz",
                            hintText: "Şifre",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (s) {
                            if (s.length < 8) {
                              return "8 Karakterden Kısa Olamaz";
                            } else
                              return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ButtonTheme(
                          minWidth: 150,
                          height: 50,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.orange,
                              child: Text("Giriş Yap",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                if (_fkey.currentState.validate()) {
                                  _fkey.currentState.save();
                                  _loginViewmodel
                                      .signInViewModel(_mailController.text,
                                          _passwordController.text)
                                      .then((value) {
                                    if (value != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    } else {
                                      return hataGeldi();
                                    }
                                  });
                                  /* _loginViewmodel.state ==
                                          LoginState.LoadingState
                                      ? veriGeliyor()
                                      : _loginViewmodel.state ==
                                              LoginState.ErrorState
                                          ? hataGeldi()
                                          : _loginViewmodel.state ==
                                                  LoginState.LoadedState
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()))
                                              : Text("Hata");*/
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  veriGeliyor() {
    return CircularProgressIndicator();
  }

  hataGeldi() {
    _sKey.currentState.showSnackBar(SnackBar(
      content: Text("Kullanıcı Adı Veya Şifre Hatalı"),
      duration: Duration(seconds: 5),
    ));
  }
}
