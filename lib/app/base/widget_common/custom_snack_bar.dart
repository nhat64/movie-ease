import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Defines the type of snackbar to be displayed.
enum SnackBarType { error, success }

/// Displays a customized snackbar with the given title and message.
///
/// [title] The title of the snackbar.
/// [message] The main message of the snackbar.
/// [position] The position of the snackbar on the screen (default is TOP).
/// [type] The type of snackbar (success or error, default is success).
void showSnackBar({
  required String title,
  String? message,
  SnackPosition position = SnackPosition.TOP,
  SnackBarType type = SnackBarType.success,
}) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: _buildSnackbarContent(type, title, message),
      snackPosition: position,
      backgroundColor: Colors.transparent,
      barBlur: 1,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 30),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 350),
      forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
      borderWidth: 1,
      snackStyle: SnackStyle.FLOATING,
    ),
  );
}

/// Builds the content of the snackbar based on the given type, title, and message.
///
/// [type] The type of snackbar (success or error).
/// [title] The title of the snackbar.
/// [message] The main message of the snackbar.
///
/// Returns a Widget representing the snackbar content.
Widget _buildSnackbarContent(SnackBarType type, String title, String? message) {
  final isSuccess = type == SnackBarType.success;
  final color = isSuccess ? Colors.black : const Color(0xFFF32F2F);

  return Container(
    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border:
          isSuccess ? Border(left: BorderSide(width: 5, color: color)) : null,
      boxShadow: [
        BoxShadow(
          color: isSuccess ? const Color(0x1E0EAA0B) : const Color(0x19000000),
          blurRadius: isSuccess ? 12 : 20,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title and message column
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: message != null && message.isNotEmpty
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Visibility(
                visible: title.isNotEmpty,
                child: Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              // Message
              Visibility(
                visible: message != null && message.isNotEmpty,
                child: Text(
                  message ?? '',
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
