import 'package:flutter/material.dart';
import 'package:inventory/view_models/qr_code_view_models.dart';
import 'package:provider/provider.dart';

class SorguEkrani extends StatefulWidget {
  @override
  _SorguEkraniState createState() => _SorguEkraniState();
}

class _SorguEkraniState extends State<SorguEkrani> {
  final _textControllerIsim = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _fKey = GlobalKey<FormState>();
    String isim;
    return Consumer(
        builder: (context, QrViewModels _qrViewModel, widget) => Scaffold(
              appBar: AppBar(
                title: Text("Sorgu Ekranı"),
              ),
              body: Container(
                decoration: BoxDecoration(),
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
                        /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                              future: _viewModel.getData(),
                              builder: (context,
                                  AsyncSnapshot<List<Ebatlilar>> sonuc) {
                                if (sonuc.hasData) {
                                  return DropdownButton<String>(
                                      hint: Text("Seçiniz"),
                                      items: sonuc.data.map((e) {
                                        return DropdownMenuItem<String>(
                                          child: Text(e.isim),
                                          value: e.isim,
                                        );
                                      }).toList(),
                                      value: geciciIsim,
                                      onChanged: (s) {
                                        geciciIsim = s;
                                      });
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),*/
                        RaisedButton(
                            child: Text("Sorgula"),
                            color: Colors.blueGrey.shade100,
                            onPressed: () {
                              if (_fKey.currentState.validate()) {
                                _fKey.currentState.save();
                                isim = _textControllerIsim.text;
                                //isim = geciciIsim;
                                Navigator.pop(context, isim);
                              }
                            }),
                        RaisedButton(
                            child: Text("Qr İle Sorgula"),
                            color: Colors.blueGrey.shade100,
                            onPressed: () {
                              _qrViewModel.scanBytesViewModel().then((value) =>
                                  this._textControllerIsim.text = value);
                              //_scanBytes();
                            }),
                      ],
                    )),
              ),
            ));
  }
}
