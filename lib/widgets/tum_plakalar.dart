import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/repository/ebatli_repository.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'plaka_ekleme_dialog.dart';

class TumPlakalar extends StatefulWidget {
  @override
  _TumPlakalarState createState() => _TumPlakalarState();
}

class _TumPlakalarState extends State<TumPlakalar> {
  @override
  Widget build(BuildContext context) {
    String bejUrl =
        "https://previews.123rf.com/images/alexeybykov/alexeybykov1511/alexeybykov151100035/48245835-seamless-beige-marble-background-with-natural-pattern-tiled-cream-marble-stone-wall-texture-.jpg";
    String oliveMarronUrl =
        "https://image.freepik.com/free-photo/black-marbled-surface_53876-90798.jpg";
    String muglaBejUrl =
        "https://image.freepik.com/free-photo/close-up-black-marble-textured-background_53876-63511.jpg";
    return Consumer(
      builder: (context, EbatliViewModel _viewModel, widget) => FutureBuilder(
          future: _viewModel.getData(),
          builder: (context, AsyncSnapshot<List<Ebatlilar>> sonuc) {
            if (sonuc.hasData) {
              print("Gelen:" + sonuc.data.toString());
              return GridView.builder(
                  itemCount: sonuc.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: sonuc.data[index].isim == "Olive Marron"
                                  ? NetworkImage(oliveMarronUrl)
                                  : NetworkImage(muglaBejUrl),
                              fit: BoxFit.cover),
                        ),
                        /*color: index % 2 == 0
                                              ? Colors.orange.shade300
                                              : Colors.lightBlue.shade300,*/
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              sonuc.data[index].isim,
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 20,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                            Text(
                              "Cins: " + sonuc.data[index].cins,
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 15,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                            Text(
                              "Kalite: " + sonuc.data[index].kalite,
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 15,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                            Text(
                              "En: " + sonuc.data[index].en.toString(),
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 15,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                            Text(
                              "Boy: " + sonuc.data[index].boy.toString(),
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 15,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                            Text(
                              "Toplam Metraj: " +
                                  sonuc.data[index].metraj.toString(),
                              style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  fontSize: 15,
                                  color:
                                      sonuc.data[index].isim == "Olive Marron"
                                          ? Colors.white70
                                          : Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
