import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/models/paletler.dart';

class PaletlerRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Paletler> _tumPaletler;

  List get tumPaletler => _tumPaletler;

  //VERİ LİSTELE
  Future<QuerySnapshot> getPaletler() async {
    var snap = await _firestore.collection("Paletler").get();
    return snap;
  }

  //VERi EKLE
  Future<void> addPlaka(Paletler palet) async {
    print("Client add Tetiklendi");
    _firestore.doc("/Paletler/${palet.id}").set(palet.toMap());
  }

  //VERİ SORGULA
  Future<QuerySnapshot> paletlerGetQuerywithNameRepo(String isim) async {
    var snap = await _firestore
        .collection("Paletler")
        .where("isim", isEqualTo: isim)
        .get();
    return snap;
  }

  //ID ile VERİ SORGULA
  Future<QuerySnapshot> paletlerGetQuerywithIdRepo(String id) async {
    var snap = await _firestore
        .collection("Paletler")
        .where("id", isEqualTo: id)
        .get();
    return snap;
  }

  //ID ile SİLME İŞLEMİ
  Future<void> paletSilmeIslemiRepo(String id) async {
    print("Repo Palet Silme Tetiklendi");
    _firestore.collection("Paletler").doc("$id").delete().then((value) {
      //collection eklemeen silme yapılmaz.
      print("fireBase tetiklendi");
    });
  }
}
