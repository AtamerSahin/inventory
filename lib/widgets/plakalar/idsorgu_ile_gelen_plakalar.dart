import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/repository/ebatli_repository.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:provider/provider.dart';
import 'plaka_ekleme_dialog.dart';
import 'secilen_plaka_detay.dart';

class IdSorguileGelenPlakalar extends StatelessWidget {
  String secilenId;
  IdSorguileGelenPlakalar({@required this.secilenId});
  @override
  Widget build(BuildContext context) {
    String bejUrl =
        "https://previews.123rf.com/images/alexeybykov/alexeybykov1511/alexeybykov151100035/48245835-seamless-beige-marble-background-with-natural-pattern-tiled-cream-marble-stone-wall-texture-.jpg";
    String oliveMarronUrl =
        "https://image.freepik.com/free-photo/black-marbled-surface_53876-90798.jpg";
    String muglaBejUrl =
        "https://image.freepik.com/free-photo/close-up-black-marble-textured-background_53876-63511.jpg";
    String emperadorUrl =
        "https://thumbs.dreamstime.com/b/polished-slab-natural-spanish-emperador-dark-marble-natural-emperador-dark-marble-texture-design-decorative-129795127.jpg";
    String travertineUrl =
        "https://thumb.bibliocad.com/thumbs/content/586x440/00040000/4000/44601.webp";
    return Consumer(
      builder: (context, EbatliViewModel _viewModel, widget) => FutureBuilder(
          future: _viewModel.getQueryWithIdView(secilenId),
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
                      child: InkWell(
                        //Update Ve Delete İşlemleri için, Sardık
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecilenPlakaDetay(
                                      id: sonuc.data[index].id)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: sonuc.data[index].isim == "Olive Marron"
                                    ? NetworkImage(oliveMarronUrl)
                                    : sonuc.data[index].isim == "Dark Cream"
                                        ? NetworkImage(bejUrl)
                                        : sonuc.data[index].isim ==
                                                "Muğla White"
                                            ? NetworkImage(muglaBejUrl)
                                            : sonuc.data[index].isim ==
                                                    "Black Olive"
                                                ? NetworkImage(emperadorUrl)
                                                : NetworkImage(travertineUrl),
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
                                    color: sonuc.data[index].isim ==
                                                "Olive Marron" ||
                                            sonuc.data[index].isim ==
                                                "Black Olive"
                                        ? Colors.white70
                                        : Colors.black45),
                              ),
                              Text(
                                "Kalite: " + sonuc.data[index].kalite,
                                style: TextStyle(
                                    fontFamily: "ElYazisi",
                                    fontSize: 15,
                                    color: sonuc.data[index].isim ==
                                                "Olive Marron" ||
                                            sonuc.data[index].isim ==
                                                "Black Olive"
                                        ? Colors.white70
                                        : Colors.black45),
                              ),
                              Text(
                                "En: " + sonuc.data[index].en.toString(),
                                style: TextStyle(
                                    fontFamily: "ElYazisi",
                                    fontSize: 15,
                                    color: sonuc.data[index].isim ==
                                                "Olive Marron" ||
                                            sonuc.data[index].isim ==
                                                "Black Olive"
                                        ? Colors.white70
                                        : Colors.black45),
                              ),
                              Text(
                                "Boy: " + sonuc.data[index].boy.toString(),
                                style: TextStyle(
                                    fontFamily: "ElYazisi",
                                    fontSize: 15,
                                    color: sonuc.data[index].isim ==
                                                "Olive Marron" ||
                                            sonuc.data[index].isim ==
                                                "Black Olive"
                                        ? Colors.white70
                                        : Colors.black45),
                              ),
                              Text(
                                "Toplam Metraj: " +
                                    sonuc.data[index].metraj.toString(),
                                style: TextStyle(
                                    fontFamily: "ElYazisi",
                                    fontSize: 15,
                                    color: sonuc.data[index].isim ==
                                                "Olive Marron" ||
                                            sonuc.data[index].isim ==
                                                "Black Olive"
                                        ? Colors.white70
                                        : Colors.black45),
                              ),
                            ],
                          ),
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

  veriGeliyor() {
    return CircularProgressIndicator();
  }

  hataGeldi() {
    Text("Arama yaparken bir hata oluştu");
  }
}
