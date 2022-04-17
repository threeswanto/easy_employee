import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackBarService {
  static showSuccessSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(message: message),
    );
  }

  static showWarningSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(message: message),
    );
  }
}
