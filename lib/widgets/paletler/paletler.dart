import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:inventory/models/paletler.dart';
import 'package:inventory/view_models/paletler_view_models.dart';
import 'package:inventory/widgets/paletler/palet_ekleme_dialog.dart';
import 'package:inventory/widgets/paletler/sorgu_ekrani_id_paletler.dart';
import 'package:inventory/widgets/paletler/sorgu_ekrani_palet.dart';
import 'package:inventory/widgets/paletler/sorgu_ile_gelen_paletler.dart';
import 'package:inventory/widgets/paletler/tum_paletler.dart';
import 'package:provider/provider.dart';

import 'idsorgu_ile_geln_paletler.dart';

class PaletlerList extends StatefulWidget {
  @override
  _PaletlerListState createState() => _PaletlerListState();
}

class _PaletlerListState extends State<PaletlerList> {
  Paletler paletler;
  String secilenIsim;
  //Sorgu için seçilen yani sorgu ekranından dönen isim
  String secilenid;
  //Sorgu için seçilen yani sorgu ekranından dönen id
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, PaletlerViewModel _viewModel, widget) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              title: Text("Paletler", style: TextStyle(color: Colors.black45)),
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
                              builder: (context) => SorguEkraniPalet()));
                      _viewModel.paletlerGetQueryWithNameView(secilenIsim);
                      //GetData methodu gibi; getQuery Methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                      //GetDataya ViewModelın constructorında yazdık, çünkü açılır açılmaz veri gelmesi için
                    }),
                /*IconButton(
                    icon: Icon(Icons.get_app),
                    onPressed: () {
                      _viewModel.getData();
                      //GetData methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                    }),*/ // GetDatayı ModelView in cons unda yazdığımız için buraya gerek kalmadı.
                IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () async {
                      //_viewModel.stateGuncelle();
                      //Tüm Plakalar listelendikten sonra, isme göre sıralama yapmadan önce state i initial a çeviriyoruz.
                      //Model consta getDatayı direk yazdığımız için bu sayfa açınca tetikleniyor, burada state i initiale çeviriyoruz alıyoruz,

                      secilenid = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IdSorguEkraniPaletler()));
                      _viewModel.paletlerGetQueryWithIdView(secilenid);
                      //GetData methodu gibi; getQuery Methodunu tetikleyip, State durumunu değştirmek ve ürünleri listelemek için yazdık.
                      //GetDataya ViewModelın constructorında yazdık, çünkü açılır açılmaz veri gelmesi için
                    }),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green.shade300,
              child: Icon(Icons.add),
              onPressed: () {
                dialogAc();
              },
            ),
            //Her MEthod için mutlaka yeni state tanımlamak en kritik nokta!
            body: (_viewModel.state == PaletlerState.LoadedState)
                ? TumPaletler()
                : (_viewModel.state == PaletlerState.LoadingState)
                    ? veriGeliyor()
                    : (_viewModel.state == PaletlerState.ErrorState)
                        ? hataGeldi()
                        : (_viewModel.state == PaletlerState.Loaded2State)
                            ? SorguileGelenPaletler(
                                secilenIsim: secilenIsim,
                              )
                            : (_viewModel.state == PaletlerState.Loading2State)
                                ? veriGeliyor()
                                : (_viewModel.state ==
                                        PaletlerState.Error2State)
                                    ? hataGeldi()
                                    : (_viewModel.state ==
                                            PaletlerState.Loaded3State)
                                        ? IdSorguileGelenPaletler(
                                            secilenId: secilenid,
                                          )
                                        : (_viewModel.state ==
                                                PaletlerState.Loading3State)
                                            ? veriGeliyor()
                                            : (_viewModel.state ==
                                                    PaletlerState.Error3State)
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
    Text("Paletler getirilirken hata oluştu");
  }

  void dialogAc() {
    showDialog(
        context: (context),
        barrierDismissible: true,
        builder: (context) => PaletEkleDialogum());
  }
}
