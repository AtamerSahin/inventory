import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory/locator.dart';
import 'package:inventory/login_page.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:inventory/view_models/google_auth_view_models..dart';
import 'package:inventory/view_models/qr_code_view_models.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'view_models/paletler_view_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  //setupLocator ı mutlaka koyuyorzu yoksa locator çalışmaz.
  runApp(MultiProvider(providers: [
    //1 den fazla Provider kullanacağımız için MultiProvider oluşturduk
    (ChangeNotifierProvider<EbatliViewModel>(
      //Plakalar İçin Provider
      create: (context) => EbatliViewModel(),
    )),
    (ChangeNotifierProvider<PaletlerViewModel>(
      //Paletler için Provider
      create: (context) => PaletlerViewModel(),
    )),
    (ChangeNotifierProvider<LoginViewModel>(
      //Logim için Provider
      create: (context) => LoginViewModel(),
    )),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QrViewModels>(
      //Qr kod için yeni bir Provider ile daha sardık
      create: (context) => QrViewModels(),
      child: MaterialApp(
        title: 'Inventory App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
