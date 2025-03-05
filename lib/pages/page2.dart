import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_desk/widgets/custom_text_field.dart';
import 'package:idea_desk/widgets/dynamic_text_field_list.dart';
import 'package:idea_desk/widgets/selectable_options.dart';
import 'package:idea_desk/widgets/custom_range_slider.dart';

class Page2Controller extends GetxController {
  final projectNameController = TextEditingController();
  final productServiceController = TextEditingController();
  final uniquenessController = TextEditingController();
  final milestoneController = TextEditingController();
  final RxList<TextEditingController> milestoneControllers =
      <TextEditingController>[TextEditingController()].obs;
  var selectedIsDiscussed = ''.obs;
  var selectedReaction = ''.obs;
  var selectedLocation = ''.obs;
  var selectedGender = ''.obs;
  var selectedEducation = ''.obs;
  var ageRange = const RangeValues(12, 60).obs; // Age range: 12-60 years
  var incomeRange =
      const RangeValues(0, 1000000).obs; // Income range: 0-1,000,000 Rs
  var teamSize = 1.0.obs; // Single value for team size: 1-50

  @override
  void onClose() {
    projectNameController.dispose();
    productServiceController.dispose();
    uniquenessController.dispose();
    milestoneController.dispose();
    for (var controller in milestoneControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void addMilestoneField() {
    milestoneControllers.add(TextEditingController());
  }

  void removeMilestoneField(int index) {
    if (milestoneControllers.length > 1) {
      milestoneControllers[index].dispose();
      milestoneControllers.removeAt(index);
    }
  }

  String get projectName => projectNameController.text;
  String get productService => productServiceController.text;
  String get uniqueness => uniquenessController.text;
  String get milestone => milestoneController.text;
  List<String> get milestones =>
      milestoneControllers.map((c) => c.text).toList();
  RangeValues get age => ageRange.value;
  RangeValues get income => incomeRange.value;
  double get team => teamSize.value;
}

class Page2 extends StatelessWidget {
  final Page2Controller controller = Get.put(Page2Controller());

  final List<Map<String, dynamic>> discussed = [
    {'label': 'Yes', 'icon': Icons.fork_right},
    {'label': 'No', 'icon': Icons.design_services},
  ];
  final List<Map<String, dynamic>> location = [
    {'label': 'Local (near me)', 'icon': Icons.fork_right},
    {'label': 'Few cities', 'icon': Icons.design_services},
    {'label': 'States', 'icon': Icons.design_services},
    {'label': 'Whole Country', 'icon': Icons.design_services},
    {'label': 'Global', 'icon': Icons.design_services},
  ];
  final List<Map<String, dynamic>> gender = [
    {'label': 'Male', 'icon': Icons.male},
    {'label': 'Female', 'icon': Icons.female},
    {'label': 'Other', 'icon': Icons.transgender},
    {'label': 'All', 'icon': Icons.male_sharp},
  ];
  final List<Map<String, dynamic>> education = [
    {'label': 'No education required', 'icon': Icons.book},
    {'label': 'Minimum up to class 5th', 'icon': Icons.book_online_rounded},
    {'label': 'Minimum up to class 10th', 'icon': Icons.copy},
    {'label': 'Minimum up to class 12th', 'icon': Icons.directions_subway},
    {'label': 'Minimum Graduate', 'icon': Icons.book},
    {'label': 'Minimum Post Graduate', 'icon': Icons.book_online_rounded},
    {'label': 'Minimum PHD', 'icon': Icons.bookmark},
  ];
  final List<Map<String, dynamic>> reaction = [
    {'label': 'They liked the Idea', 'icon': Icons.fork_right},
    {
      'label': 'They encouraged to develop a prototype',
      'icon': Icons.developer_board
    },
    {
      'label':
          'They liked after using the product/service and willing to pay for it',
      'icon': Icons.payment
    },
    {
      'label': 'They could not understand properly',
      'icon': Icons.design_services
    },
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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, // 5% of screen width
                  vertical: screenHeight * 0.02, // 2% of screen height
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Lets understand your Idea in detail, CRUX ensures you of 100% security of your Idea, your Idea will never be shared with anyone, other than the authorised assessors who are going to assess your Idea for further actions.',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize:
                            screenWidth < 600 ? 16 : 20, // Responsive font size
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    CustomTextField(
                      heading: 'Name of Business/Idea',
                      controller: controller.projectNameController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      heading: 'What is your product or service',
                      controller: controller.productServiceController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      heading: 'Why it is Unique?',
                      controller: controller.uniquenessController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    DynamicTextFieldList(
                      heading:
                          'Why is your product/service different from other already available product/service (Use Plus "+ Add More" button to add every new difference/feature)',
                      controllers: controller.milestoneControllers,
                      onAddField: controller.addMilestoneField,
                      onRemoveField: controller.removeMilestoneField,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      heading:
                          'What are the major product/service milestones that have been met to date? (discussed and appreciated, tested, being used by people)',
                      controller: controller.milestoneController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label:
                            'Have you discussed the idea/venture/product/service with your closed one?',
                        options: discussed,
                        selectedOption: controller.selectedIsDiscussed.value,
                        onSelected: (value) =>
                            controller.selectedIsDiscussed.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'What was their reaction?',
                        options: reaction,
                        selectedOption: controller.selectedReaction.value,
                        onSelected: (value) =>
                            controller.selectedReaction.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Age Range Slider (Dual-ended)
                    Obx(
                      () => CustomRangeSlider(
                        heading: 'Target Age Group',
                        rangeValues: controller.ageRange.value,
                        min: 1,
                        max: 99,
                        divisions: 98, // 99 - 1 = 98 steps
                        unit: 'years',
                        isRangeSlider: true,
                        onRangeChanged: (RangeValues values) =>
                            controller.ageRange.value = values,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Monthly Income Range Slider (Dual-ended)
                    Obx(
                      () => CustomRangeSlider(
                        heading: 'Target Monthly Income',
                        rangeValues: controller.incomeRange.value,
                        min: 0,
                        max: 1000000, // Max income: 1,000,000 Rs
                        divisions: 500, // Reasonable granularity
                        unit: 'Rs',
                        isRangeSlider: true,
                        onRangeChanged: (RangeValues values) =>
                            controller.incomeRange.value = values,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'Location',
                        options: location,
                        selectedOption: controller.selectedLocation.value,
                        onSelected: (value) =>
                            controller.selectedLocation.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'Gender',
                        options: gender,
                        selectedOption: controller.selectedGender.value,
                        onSelected: (value) =>
                            controller.selectedGender.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Obx(
                      () => SelectableOptions(
                        label: 'Education',
                        options: education,
                        selectedOption: controller.selectedEducation.value,
                        onSelected: (value) =>
                            controller.selectedEducation.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Present Team Size Slider (Single-ended)
                    Obx(
                      () => CustomRangeSlider(
                        heading: 'Present Team Size',
                        singleValue: controller.teamSize.value,
                        min: 1,
                        max: 250, // Max team size: 250
                        divisions: 249, // 250 - 1 = 249 steps
                        unit: 'persons',
                        isRangeSlider: false,
                        onSingleChanged: (double value) =>
                            controller.teamSize.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
