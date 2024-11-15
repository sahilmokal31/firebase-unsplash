import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isRememberMe = false.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async {
    clearErrors();
    if (!_validateEmail(email)) {
      emailError.value = 'Enter a valid email';
    }
    if (!_validatePassword(password)) {
      passwordError.value = 'Password must be at least 6 characters';
    }
    
    if (emailError.isEmpty && passwordError.isEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        return true;
      } catch (e) {
        Get.snackbar("Login Failed", "Please check your credentials.");
      }
    }
    return false;
  }

  Future<bool> registerWithEmail(String email, String password, String confirmPassword) async {
    clearErrors();
    if (!_validateEmail(email)) {
      emailError.value = 'Enter a valid email';
    }
    if (!_validatePassword(password)) {
      passwordError.value = 'Password must be at least 6 characters';
    }
    if (confirmPassword != password) {
      confirmPasswordError.value = 'Passwords do not match';
    }

    if (emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return true;
      } catch (e) {
        Get.snackbar("Registration Failed", "Could not register user.");
      }
    }
    return false;
  }

  void updateIsRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  void clearErrors() {
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty && GetUtils.isEmail(email);
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

    var isPasswordVisible = false.obs;

  // Toggle the visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
