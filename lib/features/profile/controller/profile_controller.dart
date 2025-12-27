import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';

class ProfileController extends GetxController {
  final RxBool pushNotificationEnabled = true.obs;

  // Firebase user
  final Rx<User?> user = FirebaseAuth.instance.currentUser.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to auth changes to update UI
    FirebaseAuth.instance.authStateChanges().listen((value) {
      user.value = value;
    });
  }

  void togglePushNotification(bool value) {
    pushNotificationEnabled.value = value;
  }

  void onChangePassword() {
    Get.snackbar('Coming Soon', 'Change Password feature');
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
