import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory/locator.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
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
    (ChangeNotifierProvider<EbatliViewModel>(
      //Aslında Tema ve renk için MAterialApp i sarmamız gerekliydi ama başka widget a alıp sarmamız gerekecekti çünkü altında home kısmında diğer ChangeNotifier var
      //Oyüzden biz de bir üst ağaçtan yani runApp ten sardık.
      create: (context) => EbatliViewModel(),
    )),
    (ChangeNotifierProvider<PaletlerViewModel>(
      //Aslında Tema ve renk için MAterialApp i sarmamız gerekliydi ama başka widget a alıp sarmamız gerekecekti çünkü altında home kısmında diğer ChangeNotifier var
      //Oyüzden biz de bir üst ağaçtan yani runApp ten sardık.
      create: (context) => PaletlerViewModel(),
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
        home: HomePage(),
      ),
    );
  }
}
