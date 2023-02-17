import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whisper_dart/whisper_dart.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String model = "";
  String wav = "";
  String transcribe = "";
  bool isProcessing = false;


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

            Text("Path File Model: ${model}"),
            Text("Path File Wav: ${wav}"),

            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                // button to set model
                ElevatedButton(
                onPressed: () async {
                  FilePickerResult? resul =  await FilePicker.platform.pickFiles();
                   if (resul != null) {
                      File file = File(resul.files.single.path!);
                      if (file.existsSync()) {
                      setState(() {
                          model = file.path;
                      });
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
                    setState(() {
                      wav = file.path;
                    });
                    }
                }
                },
                  child: const Text("set audio"),
                ),
                ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isProcessing = true;
                  transcribe =  runningWhisperDart();
                });
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

            isProcessing == false
            ? Flexible(child: Text("Result to Transcribe: ${transcribe}"))
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  /// function to whisper dart in simple mode
  runningWhisperDart() async {

    Whisper whisper = Whisper();

    var get_version =
    whisper.request(whisperRequest: WhisperRequest({"@type": "getVersion"}));
    print(get_version);
    try {
      var res = whisper.request(
        whisperRequest: WhisperRequest.fromWavFile(
          audio: File(wav),
          model: File(model),
          language: "en",
        ),
      );
      print(res.toString());
      transcribe =  res.toString();
    } catch (e) {
      print(e);
    }

    setState(() {
      isProcessing = false;
    });


  }


}





