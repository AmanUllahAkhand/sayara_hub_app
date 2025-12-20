import 'package:get/get.dart';
import '../features/auth/binding/auth_binding.dart';
import '../features/home/binding/home_binding.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/splash/binding/splash_binding.dart';
import '../features/auth/view/login_screen.dart';
import '../features/home/view/home_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
