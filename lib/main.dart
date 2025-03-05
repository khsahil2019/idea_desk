import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'controllers/main_controller.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/results_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final MainController controller = Get.find<MainController>();

  void submitForm() {
    final page1Controller = Get.find<Page1Controller>();
    final page2Controller = Get.find<Page2Controller>();
    final page3Controller = Get.find<Page3Controller>();

    final page1Data = {
      'My Idea is?': page1Controller.selectedIdea.value,
      'My Business/Idea is technology based': page1Controller.isUrgent.value,
      'Technology is used': page1Controller.selectedtechUsed.value,
      'The form of technology used is':
          page1Controller.selectedformOfTech.value,
      'My Business/Idea provides an innovative solution':
          page1Controller.needsFunding.value,
      'My business/Idea provides value beyond cost':
          page1Controller.hasTeam.value,
      'Industry': page1Controller.selectedIndustry.value,
      'Has your business/Idea generated any revenue':
          page1Controller.revenue.value,
      'Legal Status': page1Controller.selectedLegalStatus.value,
    };

    final page2Data = {
      'Name of Business/Idea': page2Controller.projectName,
      'What is your product or service': page2Controller.productService,
      'Why it is Unique?': page2Controller.uniqueness,
      'Why is your product/service different': page2Controller.milestones,
      'Major product/service milestones': page2Controller.milestone,
      'Discussed with closed one': page2Controller.selectedIsDiscussed.value,
      'Their reaction': page2Controller.selectedReaction.value,
      'Target Age Group':
          '${page2Controller.ageRange.value.start.round()} - ${page2Controller.ageRange.value.end.round()} years',
      'Target Monthly Income':
          '${page2Controller.incomeRange.value.start.round()} - ${page2Controller.incomeRange.value.end.round()} Rs',
      'Location': page2Controller.selectedLocation.value,
      'Gender': page2Controller.selectedGender.value,
      'Education': page2Controller.selectedEducation.value,
      'Present Team Size': page2Controller.teamSize.value.round().toString(),
    };

    final page3Data = {
      'Expert Advice on My Idea/Concept': page3Controller.expertAdvice,
      'Space and infrastructure': page3Controller.infrastructure,
      'Funding to launch': page3Controller.funding,
      'Form a company and legal formalities': page3Controller.legalHelp,
      'Grow my team': page3Controller.growTeam,
      'Attached File': page3Controller.file?.name ?? 'None',
    };

    final allData = {
      'Page 1': page1Data,
      'Page 2': page2Data,
      'Page 3': page3Data,
    };

    debugPrint('Form Submission Data:');
    debugPrint('Page 1: $page1Data');
    debugPrint('Page 2: $page2Data');
    debugPrint('Page 3: $page3Data');

    controller.saveFormData(allData);

    // Show ResultsPage in a dialog
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
          child: ResultsPage(),
        ),
      ),
    );

    Get.snackbar('Success', 'Form Submitted! Check console and dialog.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => controller.updatePage(index),
              children: [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (controller.currentPage.value > 0)
                      ElevatedButton(
                        onPressed: controller.previousPage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.teal, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(100, 48),
                        ),
                        child: const Text('Previous'),
                      ),
                    if (controller.currentPage.value < 2)
                      ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.teal, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(100, 48),
                        ),
                        child: const Text('Next'),
                      ),
                    if (controller.currentPage.value == 2)
                      ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.teal, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(100, 48),
                        ),
                        child: const Text('Submit'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
