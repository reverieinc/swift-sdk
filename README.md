# Reverie Language API SDK for iOS
## Overview
Welcome to the Rev Language API iOS SDK documentation. This SDK provides a comprehensive suite of tools for integrating advanced language processing capabilities into your iOS applications. Whether you need transliteration, translation, text-to-speech (TTS), or speech-to-text (STT) functionalities, this SDK has you covered. Additionally, the SDK offers robust language identification features to detect the language of a given text input.
## Purpose
The purpose of this documentation is to guide developers through the process of installing, configuring, and utilizing the various components of the iOS SDK. It provides detailed instructions, code examples, and best practices to help you seamlessly integrate these features into your applications.
## Audience
This documentation is intended for developers with a basic understanding of iOS development and familiarity with concepts such as APIs and SDKs. Whether you are building a new application from scratch or adding language processing features to an existing one, this guide will provide the necessary information to leverage the full potential of the SDK.
## Prerequisites
Before you begin, ensure that you have the following prerequisites in place:

- iOS Development Environment: XCode 14.3 and above with Swift 5.7 and above
- Programming Knowledge: Basic knowledge of Swift
- API Keys: Access to valid API key and APP-ID from Reverie for the language processing services you intend to use, if applicable.
- Internet Connection: All of the features require an active internet connection to function properly.

With these prerequisites, you are ready to start exploring the powerful features of the Rev-Language-API, iOS SDK. The following sections will guide you through each component in detail, providing everything you need to integrate and use these language processing capabilities in your applications.

## Integrate the SDK in Your Application


1. Add the Swift Package using SPM:

    - Open your Xcode project.
    - Navigate to File > Swift Packages > Add Package Dependency.
    - Enter the repository URL and follow the prompts to add the package.
2. If using a version lower than Xcode 15:

    - Add Apple's AVFAudio.framework:
      - Open your Xcode project.
      - Navigate to your project settings.
      - Under the General tab, find the Frameworks, Libraries, and Embedded Content section.
      - Click the + button and add AVFAudio.framework.
      - Ensure you do not embed the framework.

> Note: Privacy Manifest has been added to the SDK as per Apple's compliance.

## Supported Services
Below is the list of API Services supported by this SDK:

- ### [Translation](Docs/Translation.md)

- ### [Transliteration](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Transliteration.md)

- ### [Text to Speech](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Text%20To%20Speech.md)

- ### [Batch Speech to Text](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Speech%20to%20Text%20%7C%20Batch.md)

- ### [File Speech to Text](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Speech%20to%20Text%7CFile.md)

- ### [Streaming Speech to Text](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Speech%20To%20Text%20%7CStreaming.md)

- ### [Language Identification](https://github.com/reverieinc/reverie-language-api-sdk-ios/blob/main/Docs/Language%20Identification.md)

License
-------
All Rights Reserved. Copyright 2024. Reverie Language Technologies Limited.(https://reverieinc.com/)

Reverie Voice Input SDK can be used according to the [Apache License, Version 2.0](LICENSE).
