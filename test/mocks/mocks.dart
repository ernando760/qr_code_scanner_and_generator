import 'dart:typed_data';

import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

List<BarcodeModel> barcodes = [
  BarcodeModel(
    id: 1,
    code: '123456',
    format: CodeFormat.qrcode,
    bytes: Uint8List.fromList([0, 1, 2, 3, 4]),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  BarcodeModel(
    id: 2,
    code: '654321',
    format: CodeFormat.codabar,
    bytes: Uint8List.fromList([5, 6, 7, 8, 9]),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  BarcodeModel(
    id: 3,
    code: 'abcdef',
    format: CodeFormat.unknown,
    bytes: Uint8List.fromList([10, 11, 12, 13, 14]),
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  BarcodeModel(
    id: 4,
    code: 'fedcba',
    format: CodeFormat.qrcode,
    bytes: Uint8List.fromList([15, 16, 17, 18, 19]),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  BarcodeModel(
    id: 5,
    code: 'a1b2c3',
    format: CodeFormat.codabar,
    bytes: Uint8List.fromList([20, 21, 22, 23, 24]),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  BarcodeModel(
    id: 6,
    code: '3c2b1a',
    format: CodeFormat.unknown,
    bytes: Uint8List.fromList([25, 26, 27, 28, 29]),
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
  ),
  BarcodeModel(
    id: 7,
    code: '1a2b3c',
    format: CodeFormat.qrcode,
    bytes: Uint8List.fromList([30, 31, 32, 33, 34]),
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
  ),
  BarcodeModel(
    id: 8,
    code: '3c2b1a',
    format: CodeFormat.codabar,
    bytes: Uint8List.fromList([35, 36, 37, 38, 39]),
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
  ),
  BarcodeModel(
    id: 9,
    code: 'abcdef',
    format: CodeFormat.unknown,
    bytes: Uint8List.fromList([40, 41, 42, 43, 44]),
    createdAt: DateTime.now().subtract(const Duration(days: 8)),
  ),
  BarcodeModel(
    id: 10,
    code: 'fedcba',
    format: CodeFormat.qrcode,
    bytes: Uint8List.fromList([45, 46, 47, 48, 49]),
    createdAt: DateTime.now().subtract(const Duration(days: 9)),
  ),
];
