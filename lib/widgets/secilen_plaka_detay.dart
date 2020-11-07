import 'package:flutter/material.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:provider/provider.dart';

class SecilenPlakaDetay extends StatelessWidget {
  String id;
  SecilenPlakaDetay({@required this.id});
  var _fKey = GlobalKey<FormState>();
  final _textControllerIsim = TextEditingController();
  final _textControllerCins = TextEditingController();
  final _textControllerId = TextEditingController();
  final _textControllerEn = TextEditingController();
  final _textControllerBoy = TextEditingController();
  final _textControllerMetraj = TextEditingController();
  final _textControllerKalite = TextEditingController();
  final _textControllerqrUrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, EbatliViewModel _viewModel, widget) => Scaffold(
              appBar: AppBar(
                title: Text("Düzenle"),
              ),
              body: FutureBuilder(
                  future: _viewModel.getQueryWithIdView(id),
                  builder: (context, AsyncSnapshot<List<Ebatlilar>> sonuc) {
                    print("Gelen Sorgu sonucu: " + sonuc.data.toString());
                    if (sonuc.hasData) {
                      _textControllerIsim.text = sonuc.data[0].isim;
                      _textControllerCins.text = sonuc.data[0].cins;
                      _textControllerId.text = sonuc.data[0].id;
                      _textControllerEn.text = sonuc.data[0].en.toString();
                      _textControllerBoy.text = sonuc.data[0].boy.toString();
                      _textControllerMetraj.text =
                          sonuc.data[0].metraj.toString();
                      _textControllerKalite.text = sonuc.data[0].kalite;
                      _textControllerqrUrl.text = sonuc.data[0].qrurl;

                      return (_viewModel.state == EbatliState.LoadingState)
                          ? veriGeliyor()
                          : (_viewModel.state == EbatliState.ErrorState)
                              ? hataGeldi()
                              : (_viewModel.state == EbatliState.LoadedState)
                                  ? Form(
                                      key: _fKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _textControllerIsim,
                                                decoration: InputDecoration(
                                                  labelText: "İsim Giriniz",
                                                  hintText: "İsim",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _textControllerCins,
                                                decoration: InputDecoration(
                                                  labelText: "Cins Giriniz",
                                                  hintText: "Cins",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    _textControllerMetraj,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Metraj Giriniz",
                                                  hintText: "Metraj",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _textControllerEn,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "En Giriniz",
                                                  hintText: "En",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _textControllerBoy,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Boy Giriniz",
                                                  hintText: "Boy",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:
                                                    _textControllerKalite,
                                                decoration: InputDecoration(
                                                  labelText: "Kalite Giriniz",
                                                  hintText: "Kalite",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _textControllerId,
                                                decoration: InputDecoration(
                                                  labelText: "Id Giriniz",
                                                  hintText: "Id",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (s) {
                                                  if (s.isEmpty) {
                                                    return "Boş Olamaz";
                                                  } else
                                                    return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                  _textControllerqrUrl.text),
                                            ),
                                            //UPDATE BUTONU
                                            ButtonTheme(
                                              minWidth: 150,
                                              height: 50,
                                              child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.red)),
                                                  child: Text("Güncelle"),
                                                  color: Colors.yellow.shade400,
                                                  onPressed: () {
                                                    if (_fKey.currentState
                                                        .validate()) {
                                                      //_fKey.currentState.save();
                                                      _viewModel.addPlakaView(
                                                          Ebatlilar(
                                                              //Update Komutu ile, Ekleme komutuset olarak aynı şekilde kullnılabilir, Oyüzdenyeni bir update Komutu açmadık.
                                                              _textControllerKalite
                                                                  .text,
                                                              _textControllerCins
                                                                  .text,
                                                              int.parse(
                                                                  _textControllerEn
                                                                      .text),
                                                              int.parse(
                                                                  _textControllerMetraj
                                                                      .text),
                                                              _textControllerId
                                                                  .text,
                                                              int.parse(
                                                                  _textControllerBoy
                                                                      .text),
                                                              _textControllerIsim
                                                                  .text,
                                                              _textControllerqrUrl
                                                                  .text));
                                                    }
                                                    (_viewModel.state ==
                                                            EbatliState
                                                                .LoadedState)
                                                        ? veriGeldi(context)
                                                        //Ana sayfa geri yüklendiği için direk GetData methodu tetikleniyor.
                                                        : (_viewModel.state ==
                                                                EbatliState
                                                                    .LoadingState)
                                                            ? veriGeliyor()
                                                            : (_viewModel
                                                                        .state ==
                                                                    EbatliState
                                                                        .ErrorState)
                                                                ? hataGeldi()
                                                                : Text("Seçim");
                                                  }),
                                            ),
                                            SizedBox(height: 20),
                                            //DELETE BUTTON
                                            ButtonTheme(
                                              minWidth: 150,
                                              height: 50,
                                              child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors.red)),
                                                  child: Text("Sil"),
                                                  color: Colors.orange.shade600,
                                                  onPressed: () {
                                                    if (_fKey.currentState
                                                        .validate()) {
                                                      _fKey.currentState.save();
                                                      _viewModel
                                                          .silmeIslemiView(
                                                              _textControllerId
                                                                  .text);
                                                    }

                                                    (_viewModel.state ==
                                                            EbatliState
                                                                .LoadedState)
                                                        ? veriGeldi(context)
                                                        //Ana sayfa geri yüklendiği için direk GetData methodu tetikleniyor.
                                                        : (_viewModel.state ==
                                                                EbatliState
                                                                    .LoadingState)
                                                            ? veriGeliyor()
                                                            : (_viewModel
                                                                        .state ==
                                                                    EbatliState
                                                                        .ErrorState)
                                                                ? hataGeldi()
                                                                : Text("Seçim");
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Text("Görüntülenmedi");
                    } else {
                      return Center(
                        child: LinearProgressIndicator(),
                      );
                    }
                  }),
            ));
  }

  veriGeliyor() {
    //Hem Listeleme,Updateidelete için Kullanılıyor
    return CircularProgressIndicator();
  }

  hataGeldi() {
    Text("Plakalar getirilirken hata oluştu");
    //Listeleme, Update, delete için Kullanılıyor
  }

  veriGeldi(BuildContext context) {
    //Sadece Update ve delete İşleminden sonra kullanılıypr
    Navigator.pop(context);
  }
}
