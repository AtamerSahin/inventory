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
}
