# whisper_dart_my_first_test_v2

I created this app to testing package whisper dart into Flutter. I tested only in Android!

What did i do?

1. imported package whisper_dart
2. i copied file libwhisper.so into folder android/app/src/main/jniLibs
3. i added code below in file android/app/build.gradle

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
        main {
            jniLibs.srcDirs = ['src/main/jniLibs']
        }
    }

4. Only run flutter app
5. into Flutter app, select set Model 
if you dont have, download it in https://huggingface.co/datasets/ggerganov/whisper.cpp/tree/main
in the test i used ggml-base.bin (148mb)

6. select on wav file, to transcribe 
for example https://github.com/ggerganov/whisper.cpp/blob/master/samples/jfk.wav

7.  click in "To Start Transcribe Audio".. It's running. Only problem that take a long time to transcribe

If you have some doubles, open issue or question here in github, thanks!

+==============================================================================

![image](https://user-images.githubusercontent.com/65929403/221388750-808165ba-9ea0-41ca-83f9-da49fb10e063.png)


![image](https://user-images.githubusercontent.com/65929403/221388765-773404de-fcf6-4552-98c6-745c5d0845f0.png)


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
