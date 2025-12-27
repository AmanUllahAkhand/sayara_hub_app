import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    // Small delay for splash UX
    await Future.delayed(const Duration(seconds: 2));

    final User? user = FirebaseAuthService.currentUser;

    if (user != null) {
      // User already logged in
      Get.offAllNamed(AppRoutes.home);
    } else {
      // User not logged in
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
