//QR İçin Kütüphaneler
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:inventory/repository/qr_code_repository.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import '../locator.dart';

enum QrState {
  InitialState,
  LoadingState,
  LoadedState,
  ErrorState,
}

class QrViewModels with ChangeNotifier {
  QrState _state;
  QrCodeRepository _qrRepo = locator<QrCodeRepository>();

  QrState get state => _state;
  set state(QrState value) {
    _state = value;
    //Bir atama yaptığımız  için notifyListener koyuyorz.
    notifyListeners();
  }

  QrViewModels() {
    _state = QrState.InitialState;
  }

  //Qr Okuyucu
  Future<String> scanBytesViewModel() async {
    String gelenDeger;
    try {
      state = QrState.LoadingState;
      gelenDeger = await _qrRepo.qrScanRepo();
      state = QrState.LoadedState;
    } catch (e) {
      state = QrState.ErrorState;
    }
    return gelenDeger;
  }

  //Qr Generate
  Future<dynamic> getQrUrl(String baslik, GlobalKey globalKey) async {
    //Global Key ile birlikte Qr Kodu çözümlediği için Global key önemli, Bunuda Kullanıcı kısmından alıyoruz
    dynamic url = await _qrRepo.captureAndSharePng(baslik, globalKey);
    return url;
  }
}
