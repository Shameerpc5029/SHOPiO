import 'package:ecommerce/services/forgot_password_service/forgot_password_service.dart';
import 'package:ecommerce/view/sign_in/forgot_password/widgets/new_password_success.dart';
import 'package:flutter/material.dart';

class NewPasswordProvider extends ChangeNotifier {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  void success(context, email) {
    isLoading = true;
    notifyListeners();
    ForgotPasswordService()
        .changePassword(email, newPasswordController.text)
        .then((value) {
      if (value != null) {
        isLoading = false;
        notifyListeners();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return const NewPassSuccessBottom();
          },
        );
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
