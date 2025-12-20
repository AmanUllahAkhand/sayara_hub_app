import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_svgs.dart';

class PopularService {
  final String imagePath;
  final String title;

  PopularService({required this.imagePath, required this.title});
}

class Garage {
  final String imagePath; // PNG/JPG
  final String name;
  final double rating;
  final int reviewCount;
  final double distance;
  final bool isOpen;
  final String services;

  Garage({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.isOpen,
    required this.services,
  });
}

class HomeController extends GetxController {
  // Auto-scrolling brand logos (PNG from constants)
  final List<String> brandLogos = [
    AppImages.Subaru,
    AppImages.nissan,
    AppImages.Chery,
    AppImages.Suzuki,
    AppImages.toyota,
    AppImages.datsun,
    AppImages.hyundi,
    AppImages.honda,
    AppImages.bmw,
    AppImages.mazda,
    AppImages.toyota,
    AppImages.Daihatsu,
    AppImages.mercedesBenz,
    AppImages.mitsubishi,
    AppImages.audi,
  ];

  final PageController brandPageController = PageController(viewportFraction: 0.25);
  final currentBrandIndex = 0.obs;

  // Popular Services with PNG icons
  final List<PopularService> popularServices = [
    PopularService(imagePath: AppSvgs.aCRep, title: 'AC Repair'),
    PopularService(imagePath: AppSvgs.Tires, title: 'Tires'),
    PopularService(imagePath: AppSvgs.Engine, title: 'Engine'),
    PopularService(imagePath: AppSvgs.electrical, title: 'Electrical'),
    PopularService(imagePath: AppSvgs.battery, title: 'Battery'),
    PopularService(imagePath: AppSvgs.spares, title: 'Spares'),
  ];

  // Top Rated Garages
  final List<Garage> topGarages = [
    Garage(
      imagePath: AppImages.alMajidAutoService,
      name: 'Al Majid Auto Service',
      rating: 4.8,
      reviewCount: 127,
      distance: 2.3,
      isOpen: true,
      services: 'AC · Engine · Brakes',
    ),
    Garage(
      imagePath: AppImages.emirates,
      name: 'Emirates Auto',
      rating: 4.6,
      reviewCount: 89,
      distance: 1.8,
      isOpen: true,
      services: 'Luxury · German Cars',
    ),
  ];

  Timer? _autoScrollTimer;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    // Cancel any existing timer if needed (safe restart)
    _autoScrollTimer?.cancel();

    _autoScrollTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (!brandPageController.hasClients) return;

      int nextPage = brandPageController.page?.round() ?? 0;
      nextPage++; // Always move forward

      // Animate to next page (infinite because itemCount is null)
      brandPageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  void onEmergencyTap() {
    debugPrint("Emergency Service");
  }

  void onPopularServiceTap(String title) {
    debugPrint("$title tapped");
  }

  void onGarageTap(String name) {
    debugPrint("$name tapped");
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    brandPageController.dispose();
    super.onClose();
  }
}