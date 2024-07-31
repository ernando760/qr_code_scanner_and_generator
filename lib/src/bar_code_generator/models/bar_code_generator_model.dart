import 'package:flutter/cupertino.dart';

class BarCodeGeneratorModel {
  final String qrData;
  final String textData;

  BarCodeGeneratorModel({required this.qrData, required this.textData});

  BarCodeGeneratorModel copyWith(
      {ValueGetter<String>? qrData, ValueGetter<String>? textData}) {
    return BarCodeGeneratorModel(
        qrData: qrData?.call() ?? this.qrData,
        textData: textData?.call() ?? this.textData);
  }

  factory BarCodeGeneratorModel.empty() {
    return BarCodeGeneratorModel(qrData: "", textData: "");
  }
}
