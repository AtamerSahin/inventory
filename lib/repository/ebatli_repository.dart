import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/ebatli.dart';

class EbatliRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Ebatlilar> _tumEbatlilar;

  List get tumEbatlilar => _tumEbatlilar;

  //VERİ LİSTELE
  Future<QuerySnapshot> getEbatlilar() async {
    var snap = await _firestore.collection("Plakalar").get();
    return snap;
  }

  //VERi EKLE
  Future<void> addPlaka(Ebatlilar ebatli) async {
    print("Client add Tetiklendi");
    _firestore.doc("/Plakalar/${ebatli.id}").set(ebatli.toMap());
  }

  //VERİ SORGULA
  Future<QuerySnapshot> getQuerywithNameRepo(String isim) async {
    var snap = await _firestore
        .collection("Plakalar")
        .where("isim", isEqualTo: isim)
        .get();
    return snap;
  }

  //ID ile VERİ SORGULA
  Future<QuerySnapshot> getQuerywithIdRepo(String id) async {
    var snap = await _firestore
        .collection("Plakalar")
        .where("id", isEqualTo: id)
        .get();
    return snap;
  }

  //ID ile SİLME İŞLEMİ
  Future<void> silmeIslemiRepo(String id) async {
    print("Repo Silme Tetiklendi");
    _firestore.collection("Plakalar").doc("$id").delete().then((value) {
      //collection eklemeen silme yapılmaz.
      print("fireBase tetiklendi");
    });
  }
}
