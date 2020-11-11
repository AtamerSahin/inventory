import 'package:flutter/material.dart';
import 'package:inventory/view_models/qr_code_view_models.dart';
import 'package:provider/provider.dart';

class SorguEkraniPalet extends StatefulWidget {
  @override
  _SorguEkraniPaletState createState() => _SorguEkraniPaletState();
}

class _SorguEkraniPaletState extends State<SorguEkraniPalet> {
  final _textControllerIsim = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _fKey = GlobalKey<FormState>();
    String isim;
    return Consumer(
        builder: (context, QrViewModels _qrViewModel, widget) => Scaffold(
              appBar: AppBar(
                title: Text("İsim Sorgu Ekranı",
                    style: TextStyle(color: Colors.black45)),
                backgroundColor: Colors.green.shade300,
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
                        ButtonTheme(
                          minWidth: 150,
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          child: RaisedButton(
                              child: Text("Sorgula"),
                              color: Colors.green.shade300,
                              onPressed: () {
                                if (_fKey.currentState.validate()) {
                                  _fKey.currentState.save();
                                  isim = _textControllerIsim.text;
                                  //isim = geciciIsim;
                                  Navigator.pop(context, isim);
                                }
                              }),
                        ),
                      ],
                    )),
              ),
            ));
  }
}
