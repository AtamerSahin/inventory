import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/repository/ebatli_repository.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:inventory/widgets/sorgu_ekrani.dart';
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
  String secilenIsim;
  //Sorgu için seçilen isim
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, EbatliViewModel _viewModel, widget) => Scaffold(
            appBar: AppBar(
              title: Text("Plakalar"),
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      //_viewModel.stateGuncelle();
                      //Tüm Plakalar listelendikten sonra, isme göre sıralama yapmadan önce state i initial a çeviriyoruz.
                      //Model consta getDatayı direk yazdığımız için bu sayfa açınca tetikleniyor, burada state i initiale çeviriyoruz alıyoruz,

                      secilenIsim = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SorguEkrani()));
                      _viewModel.getQueryWithNameView(secilenIsim);
                      //GetData methodu gibi; getQuery Methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                      //GetDataya ViewModelın constructorında yazdık, çünkü açılır açılmaz veri gelmesi için
                    }),
                /*IconButton(
                    icon: Icon(Icons.get_app),
                    onPressed: () {
                      _viewModel.getData();
                      //GetData methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                    }),*/ // GetDatayı ModelView in cons unda yazdığımız için buraya gerek kalmadı.
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                dialogAc();
              },
            ),
            //Her MEthod için mutlaka yeni state tanımlamak en kritik nokta!
            body: (_viewModel.state == EbatliState.LoadedState)
                ? TumPlakalar()
                : (_viewModel.state == EbatliState.LoadingState)
                    ? veriGeliyor()
                    : (_viewModel.state == EbatliState.ErrorState)
                        ? hataGeldi()
                        : (_viewModel.state == EbatliState.Loaded2State)
                            ? SorguileGelenPlakalar(
                                secilenIsim: secilenIsim,
                              )
                            : (_viewModel.state == EbatliState.Loading2State)
                                ? veriGeliyor()
                                : (_viewModel.state == EbatliState.Error2State)
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
    Text("Plakalar getirilirken hata oluştu");
  }

  void dialogAc() {
    showDialog(
        context: (context),
        barrierDismissible: true,
        builder: (context) => Dialogum());
  }
}
