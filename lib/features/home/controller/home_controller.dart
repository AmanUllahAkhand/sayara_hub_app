import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_svgs.dart';

/// --------------------
/// MODELS
/// --------------------

class PopularService {
  final String imagePath;
  final String title;

  PopularService({
    required this.imagePath,
    required this.title,
  });
}

class Garage {
  final String imagePath;
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

/// --------------------
/// CONTROLLER
/// --------------------

class HomeController extends GetxController {
  /// Brand Logos (PNG)
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
    AppImages.Daihatsu,
    AppImages.mercedesBenz,
    AppImages.mitsubishi,
    AppImages.audi,
  ];

  /// Page Controller for infinite auto scroll
  late final PageController brandPageController;

  /// Auto scroll timer
  Timer? _autoScrollTimer;

  /// Current visible page (for tracking if needed)
  var currentBrandPage = 0.obs;

  /// Popular Services
  final List<PopularService> popularServices = [
    PopularService(imagePath: AppSvgs.aCRep, title: 'AC Repair'),
    PopularService(imagePath: AppSvgs.Tires, title: 'Tires'),
    PopularService(imagePath: AppSvgs.Engine, title: 'Engine'),
    PopularService(imagePath: AppSvgs.electrical, title: 'Electrical'),
    PopularService(imagePath: AppSvgs.battery, title: 'Battery'),
    PopularService(imagePath: AppSvgs.spares, title: 'Spares'),
  ];

  /// Top Rated Garages
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

  /// --------------------
  /// LIFECYCLE
  /// --------------------

  @override
  void onInit() {
    super.onInit();

    // Start in the "middle" of an infinite list to enable seamless looping
    const int fakeInfiniteOffset = 1000;
    brandPageController = PageController(
      viewportFraction: 0.25,
      initialPage: fakeInfiniteOffset,
    );

    // Listen to page changes to update currentBrandPage if needed
    brandPageController.addListener(() {
      if (brandPageController.page != null) {
        currentBrandPage.value = brandPageController.page!.round();
      }
    });

    // Start auto scroll after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  /// --------------------
  /// AUTO SCROLL LOGIC (Seamless Infinite Loop)
  /// --------------------

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();

    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 2), // Time between each auto-advance
          (_) {
        if (!brandPageController.hasClients) return;

        // Always animate to the next page smoothly
        int nextPage = brandPageController.page!.round() + 1;

        brandPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  /// Optional: Get real brand index from infinite page
  int getRealBrandIndex(int infinitePage) {
    return infinitePage % brandLogos.length;
  }

  /// --------------------
  /// ACTIONS
  /// --------------------

  void onEmergencyTap() {
    debugPrint('Emergency Service tapped');
  }

  void onPopularServiceTap(String title) {
    debugPrint('$title tapped');
  }

  void onGarageTap(String name) {
    debugPrint('$name tapped');
  }

  /// --------------------
  /// CLEANUP
  /// --------------------

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    brandPageController.dispose();
    super.onClose();
  }
}