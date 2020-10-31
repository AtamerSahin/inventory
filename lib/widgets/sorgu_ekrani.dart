import 'package:flutter/material.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/view_models/ebatli_view_models.dart';
import 'package:inventory/widgets/plakalar.dart';
import 'package:inventory/widgets/sorgu_ile_gelen_plakalar.dart';
import 'package:provider/provider.dart';

class SorguEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _fKey = GlobalKey<FormState>();
    final _textControllerIsim = TextEditingController();
    String isim;
    return Consumer(
        builder: (context, EbatliViewModel _viewModel, widget) => Scaffold(
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
                        RaisedButton(
                            child: Text("Sorgula"),
                            color: Colors.blueGrey.shade100,
                            onPressed: () {
                              if (_fKey.currentState.validate()) {
                                //_fKey.currentState.save();
                                isim = _textControllerIsim.text;
                                Navigator.pop(context, isim);
                              }
                            }),
                      ],
                    )),
              ),
            ));
  }
}
