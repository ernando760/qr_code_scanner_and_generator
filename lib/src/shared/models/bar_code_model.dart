import 'package:flutter/foundation.dart';

class BarcodeModel {
  final int? id;
  final String? code;
  final CodeFormat format;
  final Uint8List? bytes;
  final DateTime createdAt;
  BarcodeModel(
      {this.id,
      this.code,
      required this.format,
      this.bytes,
      required this.createdAt});

  factory BarcodeModel.empty() =>
      BarcodeModel(format: CodeFormat.unknown, createdAt: DateTime.now());

  BarcodeModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? code,
    ValueGetter<CodeFormat?>? format,
    ValueGetter<Uint8List?>? bytes,
    ValueGetter<DateTime?>? createdAt,
  }) {
    return BarcodeModel(
        id: id?.call() ?? this.id,
        code: code?.call() ?? this.code,
        format: format?.call() ?? this.format,
        bytes: bytes?.call() ?? this.bytes,
        createdAt: createdAt?.call() ?? this.createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "code": code,
      "format": format.name,
      "bytes": bytes,
      "created_at": createdAt.microsecondsSinceEpoch
    };
  }

  factory BarcodeModel.fromMap(Map<String, dynamic> map) {
    return BarcodeModel(
        id: map["id"] as int?,
        code: map["code"] as String,
        format: CodeFormat.values
            .firstWhere((element) => element.name == map["format"] as String),
        bytes: map["bytes"] as Uint8List?,
        createdAt:
            DateTime.fromMicrosecondsSinceEpoch(map["created_at"] as int));
  }

  @override
  String toString() =>
      "$runtimeType(id: $id, code: $code, format: $format, bytes: $bytes, createdAt: $createdAt)";
}

enum CodeFormat {
  aztec,
  qrcode,
  codabar,
  unknown;
}
