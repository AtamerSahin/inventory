import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory/locator.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:inventory/view_models/qr_code_view_models.dart';
import 'package:provider/provider.dart';
import 'widgets/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  //setupLocator ı mutlaka koyuyorzu yoksa locator çalışmaz.
  runApp(ChangeNotifierProvider<EbatliViewModel>(
      //Aslında Tema ve renk için MAterialApp i sarmamız gerekliydi ama başka widget a alıp sarmamız gerekecekti çünkü altında home kısmında diğer ChangeNotifier var
      //Oyüzden biz de bir üst ağaçtan yani runApp ten sardık.
      create: (context) => EbatliViewModel(),
      child: MyApp()));
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
        home: HomePage(),
      ),
    );
  }
}
