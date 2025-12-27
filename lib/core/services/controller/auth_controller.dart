import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_auth_service.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FirebaseAuthService.authStateChanges());
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await FirebaseAuthService.signInWithGoogle();
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await FirebaseAuthService.signOut();
  }
}
