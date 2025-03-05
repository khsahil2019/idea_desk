import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_switch.dart';
import '../widgets/selectable_options.dart';

class Page1Controller extends GetxController {
  var teamSize = const RangeValues(10, 20).obs;
  var budget = const RangeValues(1000, 5000).obs;
  var isUrgent = false.obs;
  var needsFunding = false.obs;
  var hasTeam = false.obs;
  var revenue = false.obs;
  var selectedIndustry = ''.obs;
  var selectedLegalStatus = ''.obs;
  var selectedIdea = ''.obs;
  var selectedtechUsed = ''.obs;
  var selectedformOfTech = ''.obs;
}

class Page1 extends StatelessWidget {
  final Page1Controller controller = Get.put(Page1Controller());

  final List<Map<String, dynamic>> industry = [
    {'label': 'Energy', 'icon': Icons.web},
    {'label': 'Clean Tech', 'icon': Icons.design_services},
    {'label': 'Education', 'icon': Icons.search},
    {'label': 'Fintech', 'icon': Icons.search_off},
    {'label': 'Healthcare/Bio Tech', 'icon': Icons.phone_android},
    {'label': 'Software as Service', 'icon': Icons.code},
    {'label': 'Transportation', 'icon': Icons.article},
    {'label': 'Customer Goods and services', 'icon': Icons.lightbulb},
    {'label': 'Others', 'icon': Icons.more_horiz}
  ];

  final List<Map<String, dynamic>> legalStatus = [
    {'label': 'Incorporated', 'icon': Icons.web},
    {'label': 'Not Incorporated', 'icon': Icons.design_services},
  ];

  final List<Map<String, dynamic>> techUsed = [
    {
      'label': 'At the time of procurement of information/data/raw material',
      'icon': Icons.web
    },
    {
      'label':
          'At the time of delivery- product/service is delivered with the help of technology',
      'icon': Icons.design_services
    },
    {
      'label': 'To showcase the product/services in detail with usage details',
      'icon': Icons.design_services
    },
    {
      'label':
          'Technology is involved right from the beginning till delivery and customer',
      'icon': Icons.design_services
    },
  ];

  final List<Map<String, dynamic>> formOfTech = [
    {'label': 'An app/website for procurement', 'icon': Icons.web},
    {
      'label': 'An app/website for display and ordering',
      'icon': Icons.design_services
    },
    {'label': 'An app/website for usage', 'icon': Icons.design_services},
    {'label': 'An app/website for delivery', 'icon': Icons.design_services},
    {'label': 'An app/website for monitoring', 'icon': Icons.design_services},
    {
      'label': 'An app/website for all the process',
      'icon': Icons.design_services
    },
    {'label': 'A device based on IoT', 'icon': Icons.design_services},
    {'label': 'IoT', 'icon': Icons.design_services},
    {
      'label': 'Something related to VR/AR/MR/XR',
      'icon': Icons.design_services
    },
    {
      'label': 'Something related to Machine Learning ML',
      'icon': Icons.design_services
    },
    {
      'label': 'Something related to Artificial Intelligence AI',
      'icon': Icons.design_services
    },
    {'label': 'Something else', 'icon': Icons.design_services},
  ];

  final List<Map<String, dynamic>> idea = [
    {'label': 'A Concept (in my mind)', 'icon': Icons.web},
    {
      'label': 'Early Stage (I have developed a prototype)',
      'icon': Icons.design_services
    },
    {
      'label': 'Expansion (Growing User/Customer base)',
      'icon': Icons.phone_android
    },
    {'label': 'Mature (I Want to Expand)', 'icon': Icons.code},
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, // 5% of screen width
                vertical: screenHeight * 0.02, // 2% of screen height
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Give wings to your ideas, turn them into a success story, came along we will nurture your idea/Concept and help you building your own startup',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: screenWidth < 600
                            ? 16
                            : 20, // Smaller font on mobile
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => SelectableOptions(
                        label: 'My Idea is?',
                        options: idea,
                        selectedOption: controller.selectedIdea.value,
                        onSelected: (value) =>
                            controller.selectedIdea.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => CustomSwitch(
                            label: 'My Business/Idea is technology based',
                            value: controller.isUrgent.value,
                            onChanged: (value) =>
                                controller.isUrgent.value = value,
                          ),
                        ),
                        Obx(
                          () => controller.isUrgent.value
                              ? SelectableOptions(
                                  label: 'Technology is used',
                                  options: techUsed,
                                  selectedOption:
                                      controller.selectedtechUsed.value,
                                  onSelected: (value) =>
                                      controller.selectedtechUsed.value = value,
                                )
                              : const SizedBox(),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Obx(
                          () => controller.isUrgent.value
                              ? SelectableOptions(
                                  label: 'The form of technology used is',
                                  options: formOfTech,
                                  selectedOption:
                                      controller.selectedformOfTech.value,
                                  onSelected: (value) => controller
                                      .selectedformOfTech.value = value,
                                )
                              : const SizedBox(),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Obx(
                          () => CustomSwitch(
                            label:
                                'My Business/Idea provides an innovative solutions to a particular problem',
                            value: controller.needsFunding.value,
                            onChanged: (value) =>
                                controller.needsFunding.value = value,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Obx(
                          () => CustomSwitch(
                            label:
                                'My business/Idea provides value to a potential customers beyond its cost',
                            value: controller.hasTeam.value,
                            onChanged: (value) =>
                                controller.hasTeam.value = value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'Industry',
                        options: industry,
                        selectedOption: controller.selectedIndustry.value,
                        onSelected: (value) =>
                            controller.selectedIndustry.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => CustomSwitch(
                        label: 'Have your business/Idea generated any revenue',
                        value: controller.revenue.value,
                        onChanged: (value) => controller.revenue.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'Legal Status',
                        options: legalStatus,
                        selectedOption: controller.selectedLegalStatus.value,
                        onSelected: (value) =>
                            controller.selectedLegalStatus.value = value,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
