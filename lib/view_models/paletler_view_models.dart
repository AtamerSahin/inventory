import 'package:flutter/material.dart';
import 'package:inventory/models/paletler.dart';
import 'package:inventory/repository/palet_repository.dart';
import '../locator.dart';

enum PaletlerState {
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

class PaletlerViewModel with ChangeNotifier {
  PaletlerState _state;
  PaletlerRepository _paletlerRepository = locator<PaletlerRepository>();
  Paletler _getirilenler;
  PaletlerViewModel() {
    _state = PaletlerState.InitialState;
    paletlerGetData();
    //Başlangıçta Çağırılması için paletlerGetData methodunu yazdık.
    //Artık Consumer içerisinde ne zaman PaletlerViewModel nesnesi üretilse orada bu method çağırılacak.
  }

  /*EbatliViewModel.sorgu() {
    _state = EbatliState.InitialState;
  }*/
  Paletler get getirilenler => _getirilenler;

  //_state i get ve set yaptık
  PaletlerState get state => _state;
  set state(PaletlerState value) {
    _state = value;
    //Bir atama yaptığımız  için notifyListener koyuyorz.
    notifyListeners();
  }

  //VERİLERİ LİSTELE
  Future<List<Paletler>> paletlerGetData() async {
    Future<List<Paletler>> a;
    try {
      state = PaletlerState.LoadingState;
      a = _paletlerRepository.getPaletler().then((value) =>
          value.docs.map((e) => Paletler.fromMap(e.data())).toList());
      state = PaletlerState.LoadedState;
    } catch (e) {
      state = PaletlerState.ErrorState;
    }
    return a;
  }

  //VERİ EKLE
  Future<void> addPaletView(Paletler palet) async {
    print("add Tetiklendi");
    try {
      state = PaletlerState.LoadingState;
      print("loading tetiklendi");
      _paletlerRepository.addPlaka(palet);
      state = PaletlerState.LoadedState;
      print("Loaded tetiklendi veri gönderildi");
    } catch (e) {
      state = PaletlerState.ErrorState;
      print("Hata Alındı");
    }
  }

  //İSME GÖRE SORGULA
  Future<List<Paletler>> paletlerGetQueryWithNameView(String isim) async {
    //Üstte Tüm plakaları Liste Methodumuzda kullandığımız state leri burada kullanamayız, Onun için yeni Stateler açtık, Çok önemli
    Future<List<Paletler>> a;
    try {
      state = PaletlerState.Loading2State;
      a = _paletlerRepository.paletlerGetQuerywithNameRepo(isim).then((value) =>
          value.docs.map((e) => Paletler.fromMap(e.data())).toList());
      state = PaletlerState.Loaded2State;
    } catch (e) {
      state = PaletlerState.Error2State;
    }

    return a;
  }

  //ID ye GÖRE SORGULA
  Future<List<Paletler>> paletlerGetQueryWithIdView(String id) async {
    //Üstte Tüm plakaları Liste Methodumuzda kullandığımız state leri burada kullanamayız, Onun için yeni Stateler açtık, Çok önemli
    Future<List<Paletler>> a;
    try {
      state = PaletlerState.Loading3State;
      a = _paletlerRepository.paletlerGetQuerywithIdRepo(id).then((value) =>
          value.docs.map((e) => Paletler.fromMap(e.data())).toList());
      state = PaletlerState.Loaded3State;
    } catch (e) {
      state = PaletlerState.Error3State;
    }

    return a;
  }

  //ID İLE SİLME İŞLEMİ
  Future<void> paletlerSilmeIslemiView(String id) async {
    print("add Tetiklendi");
    try {
      state = PaletlerState.LoadingState;
      print("loading tetiklendi");
      _paletlerRepository.paletSilmeIslemiRepo(id);
      state = PaletlerState.LoadedState;
      print("Loaded tetiklendi veri gönderildi");
    } catch (e) {
      state = PaletlerState.ErrorState;
      print("Hata Alındı");
    }
  }

  void stateGuncelle() {
    state = PaletlerState.InitialState;
  }
}
