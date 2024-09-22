import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';
import 'home_page.dart';

class ConsentFormScreen extends StatefulWidget {
  const ConsentFormScreen({super.key});

  @override
  ConsentFormScreenState createState() => ConsentFormScreenState();
}

class ConsentFormScreenState extends State<ConsentFormScreen> {
  bool isChecked = false;
  final SignatureController _controller = SignatureController(penStrokeWidth: 2, penColor: Colors.black);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final String _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consent Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informed Consent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please read the following consent form carefully and check the box to indicate your consent.',
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '''Study Title: Neuro-Enhancement Headband App Research

Principal Investigator: Aditya Mukherjee

Introduction:
I invite you to participate in a research study aimed at exploring the effects of using a mobile app connected to a neuro-enhancement headband. Before deciding to participate, it is important that you understand the purpose, procedures, risks, and benefits of this study. Please take your time to read this form carefully. If you have any questions, feel free to ask.

Purpose:
The purpose of this study is to investigate how the use of a mobile app with various neuro-enhancement features affects mental processes and personal mental improvements. Specifically, we are interested in exploring the effects of Multi-Sensory Stimulation (MSS), Transcranial Alternating Current Stimulation (tACS), AI-driven personalization, real-time EEG monitoring, and neuroplasticity-enhancing nanoparticles on cognitive functions.

Procedures:
If you agree to participate, you will be asked to:

Download and install the mobile app on your smartphone.
Sign this electronic consent form to agree to take part in the experiments.
Engage in the following activities within the app:
Multi-Sensory Stimulation (MSS): Experience haptic feedback with unique patterns and synchronized audio-visual stimulation.
Transcranial Alternating Current Stimulation (tACS): Play biofeedback games that adapt based on your performance.
AI-Driven Personalization: Receive personalized content and experience an adaptive user interface based on your interactions.
Real-Time EEG Monitoring: View interactive brainwave visualizations and use augmented reality (AR) to explore simulated brainwave activity.
Neuroplasticity Enhancing Nanoparticles: Participate in interactive learning modules and virtual lab experiments to understand the effects of nanoparticles on neural pathways.
After using the app, provide an elaborate review of the demo of the headband via the app. Completing the review form is compulsory.
Risks and Benefits:
The potential risks associated with participating in this study may include discomfort or minor irritation during the use of the app's features. However, we will take all necessary precautions to minimize these risks. The potential benefits include contributing to scientific knowledge about neuro-enhancement technologies and potentially experiencing improvements in cognitive functions.

Confidentiality and Privacy:
Your privacy is important to us. All data collected during this study will be kept confidential and stored securely. Your personal information will not be shared with any third parties without your consent.

Voluntary Participation:
Participation in this study is entirely voluntary. You have the right to withdraw from the study at any time without penalty or loss of benefits to which you are otherwise entitled.

Contact Information:
If you have any questions or concerns about this study, please contact the Principal Investigator, Aditya Mukherjee, at sophrodom.princursion@gmail.com.

Consent:
I have read and understood the information provided in this consent form. I agree to participate in the research study described above.''',
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Participant\'s Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 20),
            const Text('Signature:'),
            Signature(
              controller: _controller,
              height: 150,
              backgroundColor: Colors.grey[200]!,
            ),
            const SizedBox(height: 20),
            Text('Date: $_currentDate'),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('I agree to the terms and conditions'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isChecked && _controller.isNotEmpty && _nameController.text.isNotEmpty && _dobController.text.isNotEmpty
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      }
                    : null,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
