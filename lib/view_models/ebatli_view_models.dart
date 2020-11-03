import 'package:flutter/material.dart';
import 'package:inventory/models/ebatli.dart';
import 'package:inventory/repository/ebatli_repository.dart';

import '../locator.dart';

enum EbatliState {
  InitialState,
  LoadingState,
  LoadedState,
  ErrorState,
  Loading2State,
  Loaded2State,
  Error2State,
  Loading3State,
  Loaded3State,
  Error3State,
}

class EbatliViewModel with ChangeNotifier {
  EbatliState _state;
  EbatliRepository _ebatliRepository = locator<EbatliRepository>();
  Ebatlilar _getirilenler;
  EbatliViewModel() {
    _state = EbatliState.InitialState;
    getData();
    //Başlangıçta Çağırılması için getData yazdık.
  }
  /*EbatliViewModel.sorgu() {
    _state = EbatliState.InitialState;
  }*/
  Ebatlilar get getirilenler => _getirilenler;

  //_state i get ve set yaptık
  EbatliState get state => _state;
  set state(EbatliState value) {
    _state = value;
    //Bir atama yaptığımız  için notifyListener koyuyorz.
    notifyListeners();
  }

  //VERİLERİ LİSTELE
  Future<List<Ebatlilar>> getData() async {
    Future<List<Ebatlilar>> a;
    try {
      state = EbatliState.LoadingState;
      a = _ebatliRepository.getEbatlilar().then((value) =>
          value.docs.map((e) => Ebatlilar.fromMap(e.data())).toList());
      state = EbatliState.LoadedState;
    } catch (e) {
      state = EbatliState.ErrorState;
    }
    return a;
  }

  //VERİ EKLE
  Future<void> addPlakaView(Ebatlilar ebatli) async {
    print("add Tetiklendi");
    try {
      state = EbatliState.LoadingState;
      print("loading tetiklendi");
      _ebatliRepository.addPlaka(ebatli);
      state = EbatliState.LoadedState;
      print("Loaded tetiklendi veri gönderildi");
    } catch (e) {
      state = EbatliState.ErrorState;
      print("Hata Alındı");
    }
  }

  //İSME GÖRE SORGULA
  Future<List<Ebatlilar>> getQueryWithNameView(String isim) async {
    //Üstte Tüm plakaları Liste Methodumuzda kullandığımız state leri burada kullanamayız, Onun için yeni Stateler açtık, Çok önemli
    Future<List<Ebatlilar>> a;
    try {
      state = EbatliState.Loading2State;
      a = _ebatliRepository.getQuerywithNameRepo(isim).then((value) =>
          value.docs.map((e) => Ebatlilar.fromMap(e.data())).toList());
      state = EbatliState.Loaded2State;
    } catch (e) {
      state = EbatliState.Error2State;
    }

    return a;
  }

  //ID ye GÖRE SORGULA
  Future<List<Ebatlilar>> getQueryWithIdView(String id) async {
    //Üstte Tüm plakaları Liste Methodumuzda kullandığımız state leri burada kullanamayız, Onun için yeni Stateler açtık, Çok önemli
    Future<List<Ebatlilar>> a;
    try {
      state = EbatliState.LoadingState;
      a = _ebatliRepository.getQuerywithIdRepo(id).then((value) =>
          value.docs.map((e) => Ebatlilar.fromMap(e.data())).toList());
      state = EbatliState.LoadedState;
    } catch (e) {
      state = EbatliState.ErrorState;
    }

    return a;
  }

  //ID İLE SİLME İŞLEMİ
  Future<void> silmeIslemiView(String id) async {
    print("add Tetiklendi");
    try {
      state = EbatliState.LoadingState;
      print("loading tetiklendi");
      _ebatliRepository.silmeIslemiRepo(id);
      state = EbatliState.LoadedState;
      print("Loaded tetiklendi veri gönderildi");
    } catch (e) {
      state = EbatliState.ErrorState;
      print("Hata Alındı");
    }
  }

  void stateGuncelle() {
    state = EbatliState.InitialState;
  }
}
