import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  static const String defaultEmail = 'joguisa@gmail.com';
  static const String defaultPassword = 'joguisa98';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    if (kDebugMode) {
      print(formKey.currentState?.validate());
    }

    if (kDebugMode) {
      print('$email - $password');
    }

    return formKey.currentState?.validate() ?? false;
  }

  bool validateCredentials() {
    return email == LoginFormProvider.defaultEmail &&
        password == LoginFormProvider.defaultPassword;
  }
}
