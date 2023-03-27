<a name="readme-top"></a>



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/nnpanh/advanced-mobile-chat-gpt-flutter">
    <img src="assets/chatgpt_logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Voice ChatGPT</h3>

  <p align="center">
    A Flutter application that uses OpenAI's GPT-3 language model to generate text based on user inputs.
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Platforms</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This application is implemented following the requirements from HCMUS - Advanced Mobile Development class in 2023, Assignment 2 (25/03/2023 - 10/04/2023)

Requirements:
* Automated chatbots with text: chat and auto-reply to text messages with GPT chat API
* Chat with microphone and convert text: Users can input content with a microphone (you can set it to either hold to speak or start/stop to speak), the recorded audio is automatically converted to text in the chat screen (speech to text) to talk to the chatbot.
* Read out-loud text: chatbot responds as text and emits sound so that users can listen to the content instead of reading it (by default the application reads the text itself, the user can enable/disable reading convergence in the settings). If auto read is disabled, the user can press the Play button to hear the text read
* Support 2 languages English and Vietnamese: The application supports multi-language so that users can chat in English or Vietnamese.
* Store messages in local storage when exiting the app
* Settings: For changing language, enable/disable automatically read, delete stored chat history

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Platforms

The list below lists all the Operating System and Platforms that this application are supporting:

* Android
* iOS
* Website

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Install Flutter plugin in your IDE by following Flutter's official guide: https://docs.flutter.dev/get-started/install


### Installation

_To run the project, please follwing these steps:_

1. Get your chatGPT API Key in your [User settings](https://platform.openai.com/account/api-keys)

2. Clone the repo
   ```sh
   git clone https://github.com/nnpanh/advanced-mobile-chat-gpt-flutter.git
   ```

3. Install flutter dependencies
   ```sh
   flutter doctor
   flutter pub get
   ```

4. Enter your API in `lib/api/api_key.dart`
   ```dart
   const token = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Nguyễn Ngọc Phương Anh - MSSV: 19127097 - phuonganh19042001@gmail.com

Project Link: [https://github.com/nnpanh/advanced-mobile-chat-gpt-flutter](https://github.com/nnpanh/advanced-mobile-chat-gpt-flutter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

List of preferences:

* [FlutGPT](https://github.com/beSaif/FlutGPT?ref=flutterawesome.com)
* [Convert between text and speech](https://blog.logrocket.com/adding-speech-to-text-text-to-speech-support-flutter-app/)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

