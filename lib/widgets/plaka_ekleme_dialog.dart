import 'package:flutter/material.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:provider/provider.dart';

class Dialogum extends StatefulWidget {
  @override
  _DialogumState createState() => _DialogumState();
}

class _DialogumState extends State<Dialogum> {
  final muglaBeyazUrl =
      "https://image.freepik.com/free-photo/close-up-black-marble-textured-background_53876-63511.jpg";
  var _fKey = GlobalKey<FormState>();
  final _textControllerIsim = TextEditingController();
  final _textControllerCins = TextEditingController();
  final _textControllerId = TextEditingController();
  final _textControllerEn = TextEditingController();
  final _textControllerBoy = TextEditingController();
  final _textControllerMetraj = TextEditingController();
  final _textControllerKalite = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, EbatliViewModel _viewModel, widget) => Theme(
        data: ThemeData(
            dialogBackgroundColor: Colors.blueGrey.shade100,
            primaryColor: Colors.blue),
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text("Yeni Plaka Ekleme"),
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      muglaBeyazUrl,
                    ),
                    fit: BoxFit.fill),
              ),
              child: Form(
                  key: _fKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerIsim,
                          decoration: InputDecoration(
                            labelText: "İsim Giriniz",
                            hintText: "İsim",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerCins,
                          decoration: InputDecoration(
                            labelText: "Cins Giriniz",
                            hintText: "Cins",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerMetraj,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Metraj Giriniz",
                            hintText: "Metraj",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerEn,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "En Giriniz",
                            hintText: "En",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerBoy,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Boy Giriniz",
                            hintText: "Boy",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerKalite,
                          decoration: InputDecoration(
                            labelText: "Kalite Giriniz",
                            hintText: "Kalite",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textControllerId,
                          decoration: InputDecoration(
                            labelText: "Id Giriniz",
                            hintText: "Id",
                            border: OutlineInputBorder(),
                          ),
                          validator: (s) {
                            if (s.isEmpty) {
                              return "8 Karakterden Az olamaz";
                            } else
                              return null;
                          },
                        ),
                      ),
                      RaisedButton(
                          child: Text("Kaydet"),
                          color: Colors.blueGrey.shade100,
                          onPressed: () {
                            if (_fKey.currentState.validate()) {
                              //_fKey.currentState.save();
                              _viewModel.addPlakaView(Ebatlilar(
                                  _textControllerKalite.text,
                                  _textControllerCins.text,
                                  int.parse(_textControllerEn.text),
                                  int.parse(_textControllerMetraj.text),
                                  _textControllerId.text,
                                  int.parse(_textControllerBoy.text),
                                  _textControllerIsim.text));
                            }
                            (_viewModel.state == EbatliState.LoadedState)
                                ? veriGeldi()
                                //Ana sayfa geri yüklendiği için direk GetData methodu tetikleniyor.
                                : (_viewModel.state == EbatliState.LoadingState)
                                    ? veriGeliyor()
                                    : (_viewModel.state ==
                                            EbatliState.ErrorState)
                                        ? hataGeldi()
                                        : Text("Seçim");
                          }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  hataGeldi() {
    Text("Hava Durumu getirilirken hata oluştu");
  }

  veriGeliyor() {
    return CircularProgressIndicator();
  }

  veriGeldi() {
    Navigator.pop(context);
  }
}
