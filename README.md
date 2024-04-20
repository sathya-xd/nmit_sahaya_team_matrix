# sahaya

### Before Running App (Prerequisites) 

1. Make sure you have Flutter and Dart installed and set up on your machine. 
You can check if you have Flutter installed by running the command `flutter --version` in your terminal/command prompt. 
If Flutter is installed, it will display the version. If not, you can download and install Flutter from [here](https://flutter.dev/docs/get-started/install).

2. Ensure that you have a suitable IDE installed. Flutter supports a variety of IDEs, but the most common are [Android Studio](https://developer.android.com/studio) and Recommended:--- [VS Code](https://code.visualstudio.com/).

3. If you are using Android Studio, make sure you have the Flutter and Dart plugins installed. You can do this by going to `File -> Settings -> Plugins`, and then search for and install the Flutter and Dart plugins.

4. If you are using VS Code, make sure you have the Flutter extension installed. You can do this by going to the Extensions view (`Ctrl+Shift+X`), and then search for and install the Flutter extension.

5. Make sure you have a device to run the app on. This can be either a physical Android/iOS device, or an emulator/simulator. If you are using an emulator/simulator, make sure it is set up correctly.

6. Run Flutter Doctor in VS Code

  Before you start working with Flutter, you should run the `flutter doctor` command to see if there are any dependencies you need to install to complete the setup.

  ```bash
  flutter doctor
  ```

  This command checks your environment and displays a report to the terminal window. The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately. If everything is set up correctly, you should see a message saying that Flutter has been successfully installed. If there are any issues, they will be listed in the terminal for you to address.




### Installing and Running

1. Clone this repository:

  ```bash
  git clone https://github.com/Hemanpmanny/Sahaya--GDSC-Solution-Challenge-2024.git
  ```

2. Change into the project directory inside the Terminal:

  ```bash
 cd Sahaya--GDSC-Solution-Challenge-2024
  ```

3. Get the dependencies:

  ```bash
  flutter pub get
  ```

4. Run the app  (It will minimum 4 minutes to run app):

  ```bash
  flutter run
  ```

### :warning: Caution
  Github is scanning our code for API tokens; if any are detected, they report them to 
  OpenAI to invalidate them. Therefore please use your OPEN AI API KEY with credits 
  available and insert them to below location to chatbot to work.

  here to add your api key:
  GDSC_SAHAYA-master\lib\ChatBot\api_key.dart
