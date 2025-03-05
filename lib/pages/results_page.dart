import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../controllers/main_controller.dart';

class ResultsPage extends StatelessWidget {
  final MainController mainController = Get.find<MainController>();

  // Generate PDF content
  Future<void> generateAndPrintPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Form Submission Results',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Page 1:',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...mainController.formData['Page 1'].entries
                  .map((entry) => pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 5),
                        child: pw.Text('Q: ${entry.key}\nA: ${entry.value}',
                            style: const pw.TextStyle(fontSize: 14)),
                      )),
              pw.SizedBox(height: 20),
              pw.Text('Page 2:',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...mainController.formData['Page 2'].entries
                  .map((entry) => pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 5),
                        child: pw.Text('Q: ${entry.key}\nA: ${entry.value}',
                            style: const pw.TextStyle(fontSize: 14)),
                      )),
              pw.SizedBox(height: 20),
              pw.Text('Page 3:',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...mainController.formData['Page 3'].entries
                  .map((entry) => pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 5),
                        child: pw.Text('Q: ${entry.key}\nA: ${entry.value}',
                            style: const pw.TextStyle(fontSize: 14)),
                      )),
            ],
          );
        },
      ),
    );

    // Print or save the PDF
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formData = mainController.formData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Form Submission Results',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Page 1 Data
              const Text(
                'Page 1:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...formData['Page 1'].entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q: ${entry.key}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87)),
                        Text('A: ${entry.value}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              // Page 2 Data
              const Text(
                'Page 2:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...formData['Page 2'].entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q: ${entry.key}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87)),
                        Text('A: ${entry.value}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              // Page 3 Data
              const Text(
                'Page 3:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...formData['Page 3'].entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q: ${entry.key}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87)),
                        Text('A: ${entry.value}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              // Print Button
              Center(
                child: ElevatedButton(
                  onPressed: generateAndPrintPdf,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.teal,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.teal, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(100, 48),
                  ),
                  child: const Text('Print PDF'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
