# Text to Speech
Reverie's TTS (Text-to-Speech) is a solution that turns text into lifelike speech, allowing you to create applications that talk in multiple Indic languages and build comprehensive speech-enabled products. 
The Reverie TTS service will offer neural Text-to-Speech voices, delivering innovative enhancements in speech quality through state-of-the-art machine learning approaches. You can select the ideal voice and tone to build the natural and human-like speech-enabled applications in the market to enable the interactive customer experience.
**Note: On the basis of the selected [domain](#supporting-domains) the result will vary**



### Supporting Speaker Codes

| Language  | Female      | Male                   |
|-----------|-------------|------------------------|
| Hindi     | `hi_female` | `hi_male`, `hi_male_2` |
| Gujarati  | `gu_female` | `gu_male`              |
| Tamil     | `ta_female` | `ta_male`              |
| Telugu    | `te_female` | `te_male`              |
| Marathi   | `mr_female` | `mr_male`              |
| Malayalam | `ml_female` | `ml_male`              |
 | Bengali   | `bn_female` | `bn_male`              |
| Kannada   | `kn_female` | `kn_male`              |
| Punjabi   | `pa_female` | `pa_male`              |
| English   | `en_female` |                        |
| Assamese  | `as_female` | `as_male`              |
| Odia      | `or_female` | `or_male`              |



### Key Features
Reverie TTS API delivers remarkable robust features that effectively serve consumers in their native Indian language:
- Faster than Real-time Speech Synthesis:The TTS API will swiftly synthesize the speech output, consuming less time than the time consumed to speak in real-time. This enables real-time user experience for your users using the application.
- Customize the Speech Model:Train the text-to-speech solution to suit your requirements. The Reverie TTS will support lexicons and SSML tags, which allow you to manage the speech aspects like volume, pitch, speed rate, the pronunciation of words with context, etc.
- Text and SSML Support:Customize your speech with SSML tags that allow you to add pauses, numbers, date and time formatting, and other pronunciation instructions.
- High-Quality & Accurate Pronunciation:Attune your speech with SSML tags that allow you to add pauses, numbers, date and time formatting, and other pronunciation instructions, enabling you to deliver an accurate and high-quality voice-output.
- Optimize Your Speech Output: You can choose from various sampling rates to optimize bandwidth and audio quality for your application. The Reverie TTS supports WAV, OGG, MP3, FLAC, Ogg Opus, and PCM audio formats with sampling rates ranging from 8kHz, 16kHz, 22.05kHz, 24kHz, 44.1kHz, and 48kHz.
- Branded Custom Voices:We work with you on your voice requirements, select voice characteristics, and create and test your voice until it's ready to stand out of the crowd.

## Benefits of Reverie TTS
Reverie’s TTS builds a comprehensive speech application as it is empowered with: 
- Extensive depository of lifelike voices
- AI-optimized text processing
- Dedicated support for multiple Indic languages
- Allows customization to create unique voice personas


## SDK usage example:
1. Prepare the constructor: 
     ```sh 
                private var tts=TextToSpeech(apikey:API_KEY, appId: APP_ID)
      
    ```

2. Implement the Delegates in the Struct or Class for getting the results. 
    ```sh 
        struct TTS_UI: View,TTSDelegate {
       
        func onResult(data: Data) {
            playAudio(data: data)
        }
    
        func onError(data: String) {
        
        }
               
    ```
3. Attach the Delegates to the Text to Speech Class
    ```sh
         tts.setDelegate(ttsDelegate: self) // attach this after init in case of ViewController and after onAppear in Case of Swiftui
    ```

4.  Call the Text to Speech Function
    ```sh
        tts.callTTS(text: textInput, speaker: SelectedSpeaker)
        
    ```

5.  To Set the Speed(Optional)
    ```sh
    tts.setSpeed(1.5)
    ```

6.  To Set the Pitch(Optional)
    ```sh
    tts.setPitch(1.0)
    ```

7. To Set the SampleRate(Optional)
    ```sh
    tts.setSampleRate(44100)
    ```

8. To Set the Format(Optional)
    ```sh
    tts.setFormat("mp3")
    ```
