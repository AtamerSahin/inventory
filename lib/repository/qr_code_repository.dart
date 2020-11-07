import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeRepository {
  //Qr Okuyucu
  Future<String> qrScanRepo() async {
    final picker = ImagePicker();
    var resim = await picker.getImage(source: ImageSource.camera);
    File file = File(resim.path);
    Uint8List bytes = file.readAsBytesSync();
    String barcode = await scanner.scanBytes(bytes);
    return barcode;
  }

  //Qr Generate
  Future<dynamic> captureAndSharePng(String baslik, GlobalKey globalKey) async {
    //Global Key ile birlikte Qr Kodu çözümlediği için Global key önemli, Bunuda Kullanıcı kısmından alıyoruz
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      //await Share.file(_dataString, '$_dataString.png', pngBytes, 'image/png');
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child("users")
          .child("onur")
          .child("${baslik}.png");
      //yukarıda Storage deki klasörümüzü ve yolunu oluşturduk
      StorageUploadTask uploadTask = ref.putFile(file);
      //Belirtilen konuma resmi koyduk

      var url = await (await uploadTask.onComplete).ref.getDownloadURL();
      //REsmin Download urlsini aldık ve artık bu resmi DB mize bu değişken ile kaydedebileceğiz.
      debugPrint("Resmimizin URL si: $url");
      return url;
    } catch (e) {
      print(e.toString());
    }
  }
}
