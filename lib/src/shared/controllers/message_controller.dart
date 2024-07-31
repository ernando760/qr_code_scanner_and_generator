import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/message_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/utils/snack_bar_util.dart';

mixin MessageController on ChangeNotifier {
  MessageModel message = MessageModel.empty();
  void showMessage(MessageModel newMessage) {
    message = newMessage;
  }

  void resetMessage() {
    message = MessageModel.empty();
  }
}

mixin MessageStateNotificationMixin<T extends StatefulWidget> on State<T> {
  var _listener = () {};

  void messageControllerListener(MessageController messageController) {
    _listener = () {
      switch (messageController.message.typeMessage) {
        case TypeMessage.success:
          MessageItem.showSuccess(context, messageController.message.message);
          break;
        case TypeMessage.info:
          MessageItem.showInfo(context, messageController.message.message);
          break;
        case TypeMessage.failure:
          MessageItem.showError(context, messageController.message.message);
          break;
        default:
      }
      messageController.resetMessage();
    };

    messageController.addListener(_listener);
  }

  void removeMessageControllerListener(MessageController messageController) {
    messageController.removeListener(_listener);
  }
}

class MessageItem {
  static showSuccess(BuildContext context, String message) {
    showSnackBar(
        context, Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.greenAccent);
  }

  static showInfo(BuildContext context, String message) {
    showSnackBar(
        context, Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.yellowAccent);
  }

  static showError(BuildContext context, String message) {
    showSnackBar(
        context, Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent);
  }
}
