import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/exceptions/qr_code_image_exception.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/qr_code_image_service/i_qr_code_image_service.dart';

class MockQrcodeImageService extends Mock implements IQrcodeImageService {}

class MockPathProviderPlatform extends Mock implements Path {}

class QrQrcodeImageService extends Mock implements IQrcodeImageService {}

void main() {
  late IQrcodeImageService qrcodeImageService;

  setUp(() {
    qrcodeImageService = MockQrcodeImageService();
  });

  group("Success Tests", () {
    test(
        "Deve obter o arquivo qr code quando chamar o metodo getQrcodeImage e retornar File",
        () async {
      when(() => qrcodeImageService.getQrcodeImage(name: "qrcode_01"))
          .thenAnswer((_) async => Right(File("/qrcode_01.png")));

      final res = await qrcodeImageService.getQrcodeImage(name: "qrcode_01");

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(success?.path, "/qrcode_01.png");
      expect(success, isNotNull);
      expect(error, isNull);
    });

    test(
        "Deve salvar o qr code quando chamar o metodo getQrcodeImage e retornar File",
        () async {
      when(() => qrcodeImageService.saveQrcode(
              name: "qrcode_01", bytes: Uint8List.fromList([])))
          .thenAnswer((_) async => Right(File("/qrcode_01.png")));

      final res = await qrcodeImageService.saveQrcode(
          name: "qrcode_01", bytes: Uint8List.fromList([]));

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(success?.path, "/qrcode_01.png");
      expect(success, isNotNull);
      expect(error, isNull);
    });
  });

  group("Failure Tests", () {
    test(
        "Deve retornar uma messagem de erro 'A permissão foi negada' quando chamar o metodo [getQrcodeImage]",
        () async {
      when(() => qrcodeImageService.getQrcodeImage(name: "qrcode")).thenAnswer(
          (_) async => Left(
              QrCodeImageException(messageError: "A permissão foi negada")));

      final res = await qrcodeImageService.getQrcodeImage(name: "qrcode");

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(error?.messageError, "A permissão foi negada");
      expect(error, isNotNull);
      expect(success, isNull);
    });

    test(
        "Deve retornar uma messagem de erro 'O nome do arquivo está vazio' quando chamar o metodo [getQrcodeImage]",
        () async {
      when(() => qrcodeImageService.getQrcodeImage(name: "")).thenAnswer(
          (_) async => Left(QrCodeImageException(
              messageError: "O nome do arquivo está vazio")));

      final res = await qrcodeImageService.getQrcodeImage(name: "");

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(error?.messageError, "O nome do arquivo está vazio");
      expect(error, isNotNull);
      expect(success, isNull);
    });

    test(
        "Deve retornar uma messagem de erro 'A permissão foi negada' quando chamar o metodo [saveQrcode]",
        () async {
      when(() =>
          qrcodeImageService.saveQrcode(
              name: "qrcode",
              bytes: Uint8List.fromList([]))).thenAnswer((_) async =>
          Left(QrCodeImageException(messageError: "A permissão foi negada")));

      final res = await qrcodeImageService.saveQrcode(
          name: "qrcode", bytes: Uint8List.fromList([]));

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(error?.messageError, "A permissão foi negada");
      expect(error, isNotNull);
      expect(success, isNull);
    });

    test(
        "Deve retornar uma messagem de erro 'O nome do arquivo está vazio' quando chamar o metodo [saveQrcode]",
        () async {
      when(() =>
          qrcodeImageService.saveQrcode(
              name: "",
              bytes: Uint8List.fromList([]))).thenAnswer((_) async => Left(
          QrCodeImageException(messageError: "O nome do arquivo está vazio")));

      final res = await qrcodeImageService.saveQrcode(
          name: "", bytes: Uint8List.fromList([]));

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(error?.messageError, "O nome do arquivo está vazio");
      expect(error, isNotNull);
      expect(success, isNull);
    });

    test(
        "Deve retornar uma messagem de erro 'O qrcode não foi salvo' quando chamar o metodo [saveQrcode]",
        () async {
      when(() =>
          qrcodeImageService.saveQrcode(
              name: "qrcode",
              bytes: Uint8List.fromList([]))).thenAnswer((_) async =>
          Left(QrCodeImageException(messageError: "O qrcode não foi salvo")));

      final res = await qrcodeImageService.saveQrcode(
          name: "qrcode", bytes: Uint8List.fromList([]));

      final success = res.fold((_) {}, (success) => success);
      final error = res.fold((error) => error, (_) {});

      debugPrint("Success: $success");
      debugPrint("Error: ${error?.messageError}");
      expect(error?.messageError, "O qrcode não foi salvo");
      expect(error, isNotNull);
      expect(success, isNull);
    });
  });
}
