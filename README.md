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
* Chatbot tự động với dạng text: chat và trả lời tự động theo dạng text message với API của chat GPT
* Chat với microphone và chuyển đổi văn bản: Người dùng có thể nhập liệu nội dung bằng microphone (bạn có thể cái đặt theo 1 trong 2 dạng hold to speak hoặc start/stop to speak), âm thanh thu được tự động chuyển thành dạng text trong màn hình chat (speech to text) để nói chuyện với chatbot.
* Đọc văn bản: chatbot trả lời dạng text và phát ra âm thanh để người dùng có thể nghe nội dung thay vì đọc (mặc định ứng dụng tự đọc văn bản, người dùng có thể enable/disable việc tụ đọc trong settings. Nếu tự đọc bị disable thì người dùng có thể press nút Play để nghe đọc văn bản)
* Hỗ trợ 2 ngôn ngữ tiếng Anh và tiếng Việt: Ưng dụng hỗ đa ngôn ngữ để người dùng có thể chat bằng tiếng Anh hoặc tiếng Việt.
* Lưu trữ message trong local storage khi thoát khỏi app
* Settings: Cho thay đổi ngôn ngữ, enable/disable tự động đọc, xóa lịch sử chat đã lưu trữ

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

