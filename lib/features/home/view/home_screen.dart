import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sayara_hub_app/core/constants/app_colors.dart';
import 'package:sayara_hub_app/core/widgets/custom_text_view.dart';
import '../../../core/constants/app_svgs.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              AppSvgs.carIcon,
              width: 37,
              height: 37,
            ),
            const SizedBox(width: 8),
            CustomTextView(
              text: 'SayaraHub',
              fontSize: 28,
              fontWeight: FontWeight.w700,
            )
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Find Car Services Near You
            _buildFindServicesSection(),
            const SizedBox(height: 24),
            // 2. Emergency Service
            _buildEmergencySection(),
            const SizedBox(height: 24),
            // 3. Popular Services
            _buildPopularServicesSection(),
            const SizedBox(height: 24),
            // 4. Top Rated Garages
            _buildTopGaragesSection(),
          ],
        ),
      ),
    );
  }

  // 1. Find Car Services Near You
  Widget _buildFindServicesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.homeprimary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextView(
            text: 'Find Car Services Near You',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.scaffoldBackground,
          ),
          const SizedBox(height: 6),
          CustomTextView(
            text: 'Emergency repairs, maintenance & more',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.scaffoldBackground,
          ),
          const SizedBox(height: 20),

          // Search Fields + Button Container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _dropdownField('Location')),
                    const SizedBox(width: 7),
                    Expanded(child: _dropdownField('Service type')),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle search action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homeprimary,
                      foregroundColor: AppColors.scaffoldBackground,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Search garage',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Auto-scrolling Brand Logos with white rounded container
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 60,
              child: Align(
                alignment: Alignment.centerLeft, // 👈 forces left alignment
                child: PageView.builder(
                  controller: controller.brandPageController,
                  itemCount: controller.brandLogos.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padEnds: false, // 👈 IMPORTANT
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset(
                        controller.brandLogos[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
      child:
      CustomTextView(
          text: hint,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,)
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  // 2. Emergency Service
  Widget _buildEmergencySection() {
    return GestureDetector(
      onTap: controller.onEmergencyTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.warning,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white, size: 25),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    text:'Emergency Service',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.scaffoldBackground,
                  ),
                  CustomTextView(
                    text:'24/7 Available',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.scaffoldBackground,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: controller.onEmergencyTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.scaffoldBackground,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: CustomTextView(
                text:'Search Now',
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.warning,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Popular Services
  Widget _buildPopularServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          text: 'Popular Services',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: controller.popularServices.length,
          itemBuilder: (context, index) {
            final service = controller.popularServices[index];
            return GestureDetector(
              onTap: () => controller.onPopularServiceTap(service.title),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color:AppColors.divider,),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      service.imagePath,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: CustomTextView(
                        text: service.title,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // 4. Top Rated Garages
  Widget _buildTopGaragesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextView(
              text: 'Top Rated Garages',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            TextButton(onPressed: () {},
                child: CustomTextView(
                  text: 'View All',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.link,
                ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.topGarages.length,
          itemBuilder: (context, index) {
            final garage = controller.topGarages[index];
            return GestureDetector(
              onTap: () => controller.onGarageTap(garage.name),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(garage.imagePath, width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(garage.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              Text(' ${garage.rating} (${garage.reviewCount})',
                                  style: const TextStyle(fontSize: 12)),
                              Text(' • ${garage.distance} km', style: TextStyle(color: Colors.grey.shade600)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.circle, color: garage.isOpen ? Colors.green : Colors.red, size: 10),
                              const SizedBox(width: 4),
                              Text(garage.isOpen ? 'Open' : 'Closed',
                                  style: TextStyle(color: garage.isOpen ? Colors.green : Colors.red)),
                            ],
                          ),
                          Text(garage.services, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_vert, color: Colors.grey),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}