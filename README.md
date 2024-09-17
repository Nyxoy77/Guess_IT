# **GuessIT: A Flutter App for Image Recognition**

**GuessIT** is an interactive Flutter application where users can draw objects on the screen, and the app will use the power of Google's Gemini AI to recognize and identify those objects in real time.

## Key Features

- **Interactive Drawing Board:** Users can sketch objects directly on the screen using touch input.
- **Real-time Debouncing:** Efficient handling of drawing inputs, with a debounce mechanism that prevents excessive requests to the server, ensuring smoother performance.
- **Gemini AI Integration:** The app leverages the Gemini AI API to analyze the drawings and identify the objects in real time.
- **Dynamic UI Update:** Once the object is identified, the app instantly displays the recognized object along with relevant details on the screen.

## Getting Started

### Prerequisites

Ensure the following are set up:

- Flutter development environment. Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install).
- A Gemini account with an API key. Create an account at [Gemini AI](https://deepmind.google/technologies/gemini) and retrieve your API key.

### Installation

1. Clone this repository using:
   ```bash
   git clone https://github.com/Nyxoy77/Guess_IT.git
   cd Guess_IT
   ```
2. Install the required dependencies:
   ```bash
   flutter pub get
   ```

### Configuration

1. Open the `main.dart` file and insert your Gemini API key:
   ```dart
   const String apiKey = "YOUR_GEMINI_API_KEY";
   ```
2. (Optional) Customize drawing preferences like colors and stroke width in the `DrawingPainter.dart` file to tailor the user experience.

### Running the App

1. Connect your Android/iOS device or start an emulator.
2. Run the app using:
   ```bash
   flutter run
   ```

## How It Works

1. **User Draws:** The user draws any object on the provided drawing board interface.
2. **Debouncing:** After a brief delay, the app captures the drawing as an image.
3. **Sending to Gemini:** The image is sent to the Gemini AI API via the `sendToGemini()` function for analysis.
4. **Object Recognition:** Gemini processes the image and sends a response back, identifying the drawn object.
5. **Result Display:** The app updates the interface with the recognized object and its details.

## Project Structure

- `main.dart`: The main entry point of the application.
- `drawing_page.dart`: Contains the `DrawingPage` widget responsible for the user interface.
- `send_data_to_gemini.dart`: Manages the API requests and responses from the Gemini AI.
- `drawing_board.dart`: Widget responsible for rendering the drawing area.
- `drawing_painter.dart`: Custom painter that handles the rendering of user-drawn lines and shapes.

## Contributing

We welcome contributions to improve **GuessIT**! If you would like to contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature"
   ```
4. Push to your branch:
   ```bash
   git push origin feature/your-feature
   ```
5. Open a pull request, and ensure proper documentation and code style adherence.
