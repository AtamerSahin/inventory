import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/repository/ebatli_repository.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:inventory/widgets/sorgu_dialog.dart';
import 'package:inventory/widgets/sorgu_ile_gelen_plakalar.dart';
import 'package:inventory/widgets/tum_plakalar.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import 'plaka_ekleme_dialog.dart';

class Plakalar extends StatefulWidget {
  @override
  _PlakalarState createState() => _PlakalarState();
}

class _PlakalarState extends State<Plakalar> {
  Ebatlilar ebatlilar;
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, EbatliViewModel _viewModel, widget) => Scaffold(
            appBar: AppBar(
              title: Text("Plakalar"),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      //_viewModel.stateGuncelle();
                      //Tüm Plakalar listelendikten sonra, isme göre sıralama yapmadan önce state i initial a çeviriyoruz.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SorguileGelenPlakalar()));
                    }),
                IconButton(
                    icon: Icon(Icons.get_app),
                    onPressed: () {
                      _viewModel.getData();
                      //GetData methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                dialogAc();
              },
            ),
            body: (_viewModel.state == EbatliState.LoadedState)
                ? TumPlakalar()
                : (_viewModel.state == EbatliState.LoadingState)
                    ? veriGeliyor()
                    : (_viewModel.state == EbatliState.ErrorState)
                        ? hataGeldi()
                        : Text("Seçim")));
  }

  /*ListView.builder(
                                                      itemCount: sonuc.data.length,
                                                      itemBuilder: (context, index) {
                                                        return Card(
                                                          child: ListTile(
                                                            title: Text(sonuc.data[index].isim.toString()),
                                                            subtitle: Text(sonuc.data[index].cins.toString()),
                                                          ),
                                                        );
                                                      });*/
  veriGeliyor() {
    return CircularProgressIndicator();
  }

  hataGeldi() {
    Text("Hava Durumu getirilirken hata oluştu");
  }

  void dialogAc() {
    showDialog(
        context: (context),
        barrierDismissible: true,
        builder: (context) => Dialogum());
  }
}
