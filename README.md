## GuessIT: A Flutter App for Image Recognition

This project, GuessIT, is a Flutter application that allows users to draw an object and then uses Gemini to identify it.

### Key Features

* **Drawing Board:** Users can draw an object on the screen using their finger.
* **Real-time Debounce:** Drawing updates are captured and sent to Gemini after a short delay to avoid overwhelming the server with too many requests.
* **Gemini Integration:** The app utilizes the Flutter Gemini library to send the captured image to a Gemini endpoint for object identification.
* **Dynamic Response:** Once the object is recognized, the app displays the response from Gemini.

### Getting Started

**1. Prerequisites:**

* Flutter development environment set up (see [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)):
* A Gemini account with an API key (see [https://deepmind.google/technologies/gemini/](https://deepmind.google/technologies/gemini/))

**2. Installation:**

1. Clone this repository.
2. Install dependencies: `flutter pub get`.

**3. Configuration:**

* Replace `api_key` in `main.dart` with your Gemini API key.
* (Optional) Update drawing settings like color and stroke width in `DrawingPainter.dart`.

**4. Running the App:**

* Connect your device or launch an emulator.
* Run the app: `flutter run`.

### How it Works

1. The user draws an object on the drawing board.
2. After a short delay (debounce), the drawing is captured as an image.
3. The captured image is sent to a Gemini endpoint using the `sendTo1Gemini` function.
4. Gemini processes the image and sends back a response containing the identified object.
5. The app updates the UI with the received response, displaying what the object is.

### Project Structure

* `main.dart`: Entry point of the application.
* `drawing_page.dart`: Defines the `DrawingPage` widget for drawing and capturing user input.
* `send_data_to_gemini.dart`: Handles sending captured image data to Gemini.
* `drawing_board.dart`: Defines the `DrawingBoard` widget for displaying the user's drawing.
* `drawing_painter.dart`: Custom painter for drawing lines on the canvas.

### Contributing

We welcome contributions to this project! Please feel free to fork the repository and submit pull requests. Make sure to follow our coding style and add proper documentation for your changes.
