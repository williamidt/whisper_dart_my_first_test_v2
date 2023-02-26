import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whisper_dart/whisper_dart.dart';

class HomePage extends StatelessWidget {
  /// getx
  RxString model = ''.obs;
  RxString wav = ''.obs;
  RxString transcribe = ''.obs;
  RxBool isProcessing = false.obs;
  RxString erro = ''.obs;

  /// constructor
  HomePage({Key? key}) : super(key: key);

  /// screen logic
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Test Flutter Whisper dart",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() => Text("Path File Model: ${model.value}")),
            Obx(() => Text("Path File Wav: ${wav.value}")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // button to set model
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? resul =
                        await FilePicker.platform.pickFiles();
                    if (resul != null) {
                      File file = File(resul.files.single.path!);
                      if (file.existsSync()) {
                        model.value = file.path;
                        erro.value = "";
                      }
                    }
                  },
                  child: const Text("set model"),
                ),

                const SizedBox(width: 10),

                // button to set wav
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? resul =
                        await FilePicker.platform.pickFiles();
                    if (resul != null) {
                      File file = File(resul.files.single.path!);
                      if (file.existsSync()) {
                        wav.value = file.path;
                        erro.value = "";
                      }
                    }
                  },
                  child: const Text("set audio"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (model.value.trim().isNotEmpty &&
                    wav.value.trim().isNotEmpty) {
                  await runningWhisperDart();
                } else {
                  if (wav.value.trim().isEmpty) {
                    erro.value = "Please, select wav file before to the running";
                  }
                  if (model.value.trim().isEmpty) {
                   erro.value = "Please, select the model *.bin";
                  }
                }
              },
              child: const Text(
                "To start Transcribe Audio...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => isProcessing.isTrue ?
                const CircularProgressIndicator(): const Center()),

            Obx(() => Text("Result to Transcribe: ${transcribe.value}")),

            const SizedBox(height: 30),

            Obx(() => Text(erro.value,
                style: const TextStyle(
                  color: Colors.red,
                ))),
          ],
        ),
      ),
    );
  }

  /// function to whisper dart in simple mode
  runningWhisperDart() async {
    isProcessing.value = true;

    /// process lib whisper
    Whisper whisper = Whisper();
    var get_version = whisper.request(
        whisperRequest: WhisperRequest({"@type": "getVersion"}));
    print(get_version);
    try {
      var res = await whisper.request(
        whisperRequest: WhisperRequest.fromWavFile(
          audio: File(wav.value),
          model: File(model.value),
          language: "en",

          /// configured english transcribe en , if you need check your code in google page below
          /// https://cloud.google.com/translate/docs/languages
        ),
      );
      print(res.toString());
      isProcessing.value = false;
      transcribe.value = res.toString();
      erro.value = '';
    } catch (e) {
      print(e);
    }
    isProcessing.value = false;
  }
}

