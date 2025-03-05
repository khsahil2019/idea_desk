import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;
  var formData = {}.obs; // Observable to store form data

  void updatePage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  // Save form data
  void saveFormData(Map<String, dynamic> data) {
    formData.value = data;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
