import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:idea_desk/widgets/custom_switch.dart';

class Page3Controller extends GetxController {
  // Switch Variables
  var seeksExpertAdvice = false.obs; // Expert Advice on Idea/Concept
  var needsInfrastructure = false.obs; // Space and infrastructure
  var requiresFunding = false.obs; // Funding to launch
  var needsLegalHelp = false.obs; // Form a company and legal formalities
  var wantsToGrowTeam = false.obs; // Grow my teamss

  // File Attachment
  var attachedFile = Rxn<PlatformFile>(); // Reactive nullable file

  @override
  void onClose() {
    super.onClose();
  }

  // File Picker Method with Retry Logic
  Future<void> pickFile() async {
    try {
      // Attempt to pick a file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any, // Allow any file type (PDF, images, etc.)
        allowMultiple: false, // Single file only
      );

      if (result != null && result.files.isNotEmpty) {
        attachedFile.value = result.files.first;
        Get.snackbar('Success', 'File "${attachedFile.value!.name}" attached!');
      } else {
        Get.snackbar('Info', 'No file selected.');
      }
    } catch (e) {
      // Handle LateInitializationError or other exceptions
      if (e.toString().contains('LateInitializationError')) {
        Get.snackbar('Error', 'File picker not initialized. Retrying...');
        await Future.delayed(const Duration(seconds: 1)); // Small delay
        try {
          FilePickerResult? retryResult = await FilePicker.platform.pickFiles(
            type: FileType.any,
            allowMultiple: false,
          );
          if (retryResult != null && retryResult.files.isNotEmpty) {
            attachedFile.value = retryResult.files.first;
            Get.snackbar('Success',
                'File "${attachedFile.value!.name}" attached after retry!');
          } else {
            Get.snackbar('Info', 'No file selected on retry.');
          }
        } catch (retryError) {
          Get.snackbar('Error', 'Failed to pick file after retry: $retryError');
        }
      } else {
        Get.snackbar('Error', 'Failed to pick file: $e');
      }
    }
  }

  // Getters for accessing values
  bool get expertAdvice => seeksExpertAdvice.value;
  bool get infrastructure => needsInfrastructure.value;
  bool get funding => requiresFunding.value;
  bool get legalHelp => needsLegalHelp.value;
  bool get growTeam => wantsToGrowTeam.value;
  PlatformFile? get file => attachedFile.value;
}

class Page3 extends StatelessWidget {
  final Page3Controller controller = Get.put(Page3Controller());

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
                      'Let’s sum-up!\nBy clicking your requirements from the incubation centre, you will be responded soon about your idea. Thank you for your submission',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize:
                            screenWidth < 600 ? 16 : 20, // Responsive font size
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Requirements Section
                    Text(
                      'I am Looking for',
                      style: TextStyle(
                        fontSize:
                            screenWidth < 400 ? 18 : 22, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => CustomSwitch(
                        label: 'Expert Advice on My Idea/Concept',
                        value: controller.seeksExpertAdvice.value,
                        onChanged: (value) =>
                            controller.seeksExpertAdvice.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => CustomSwitch(
                        label:
                            'Space and infrastructure to develop the service/product',
                        value: controller.needsInfrastructure.value,
                        onChanged: (value) =>
                            controller.needsInfrastructure.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => CustomSwitch(
                        label:
                            'Funding to launch the already developed product/service',
                        value: controller.requiresFunding.value,
                        onChanged: (value) =>
                            controller.requiresFunding.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => CustomSwitch(
                        label: 'Form a company and other legal formalities',
                        value: controller.needsLegalHelp.value,
                        onChanged: (value) =>
                            controller.needsLegalHelp.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Obx(
                      () => CustomSwitch(
                        label: 'Grow my team',
                        value: controller.wantsToGrowTeam.value,
                        onChanged: (value) =>
                            controller.wantsToGrowTeam.value = value,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // File Attachment Section
                    Text(
                      'Attach Business Plan/Document (Optional)',
                      style: TextStyle(
                        fontSize:
                            screenWidth < 400 ? 14 : 16, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.attachedFile.value != null
                                  ? controller.attachedFile.value!.name
                                  : 'No file selected',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenWidth < 400
                                    ? 12
                                    : 14, // Responsive font size
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: screenWidth * 0.02), // Responsive spacing
                        ElevatedButton.icon(
                          onPressed: controller.pickFile,
                          icon:
                              const Icon(Icons.attach_file, color: Colors.teal),
                          label: Text(
                            'Pick File',
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: screenWidth < 400
                                  ? 12
                                  : 14, // Responsive font size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.teal,
                            backgroundColor: Colors.white,
                            side:
                                const BorderSide(color: Colors.teal, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenWidth * 0.03, // Responsive padding
                              vertical: screenHeight * 0.01,
                            ),
                          ),
                        ),
                      ],
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
