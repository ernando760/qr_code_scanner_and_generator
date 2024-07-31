import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TypeMessage {
  success,
  info,
  failure,
  none;
}

class MessageModel extends Equatable {
  final String message;
  final TypeMessage typeMessage;

  const MessageModel({required this.message, required this.typeMessage});

  factory MessageModel.empty() =>
      const MessageModel(message: "", typeMessage: TypeMessage.none);

  factory MessageModel.success({required String message}) =>
      MessageModel(message: message, typeMessage: TypeMessage.success);

  factory MessageModel.info({required String message}) =>
      MessageModel(message: message, typeMessage: TypeMessage.info);

  factory MessageModel.error({required String message}) =>
      MessageModel(message: message, typeMessage: TypeMessage.failure);

  MessageModel copyWith(ValueGetter<String>? message,
          ValueGetter<TypeMessage>? typeMessage) =>
      MessageModel(
          message: message?.call() ?? this.message,
          typeMessage: typeMessage?.call() ?? this.typeMessage);

  @override
  List<Object?> get props => [message, typeMessage];
}
