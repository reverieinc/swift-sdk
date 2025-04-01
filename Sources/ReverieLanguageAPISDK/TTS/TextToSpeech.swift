/*
 * All Rights Reserved. Copyright 2024. Reverie Language Technologies Limited.(https://reverieinc.com/)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

public class TextToSpeech: HttpUrlRequestDelegates{
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.TTS)
        {
            self.ttsDelegate?.onResult(data: data)
            Logger.printLog(string: "Sucess TTS")
        }
    }
    
    func onError(error: String, tag: String,errorTag:Int) {
        if(tag==ApiTag.TTS)
        {
            self.ttsDelegate?.onError(data: error,errorTag:errorTag)
        }
    }
    
    struct RequestBodyTTS: Encodable {
        let text:String
        let speed:Float?
        let pitch:Float?
        let sample_rate:Int?
        let format:String?
        
        
    }
    private var apikey:String=""
    private var appId:String=""
    private var ttsDelegate:TextToSpeechDelegate?
    private var speed: Float?
    private var pitch: Float?
    private var sample_rate: Int?
    private var format: String?
    public init(apikey: String, appId: String) {
        self.apikey = apikey
        self.appId = appId
        
    }
    public func setSpeed(_ newValue: Float?) {
        speed = newValue
    }
    
    public func setPitch(_ newValue: Float?) {
        pitch = newValue
    }
    
    public func setSampleRate(_ newValue: Int?) {
        sample_rate = newValue
    }
    
    public func setFormat(_ newValue: String?) {
        format = newValue
    }
    
    public func setDelegate(ttsDelegate:TextToSpeechDelegate)
    {
        self.ttsDelegate=ttsDelegate
        
    }
    public func callTTS(text:String,speaker:String)
    {
        do { guard let url = URL(string: "\(Constants.HTTP_URL)") else {
             Logger.printLog(string:"Invalid URL")
            self.ttsDelegate?.onError(data: "Invalid URL",errorTag:ErrorTag.SDK_ERROR)
            return
        }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(apikey, forHTTPHeaderField: RequestHeaderTag.RevApiKey )
            request.addValue(appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
            request.addValue(speaker, forHTTPHeaderField: "speaker")
            request.addValue("tts", forHTTPHeaderField: RequestHeaderTag.RevAppName)
            _ = text
            let requestBody = RequestBodyTTS(text: text, speed: speed, pitch: pitch, sample_rate: sample_rate, format: format)
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
            } catch {
                Logger.printLog(string:"Error creating JSON request body: \(error.localizedDescription)")
                self.ttsDelegate?.onError(data: error.localizedDescription,errorTag:ErrorTag.SDK_ERROR)
                return
            }
            let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
            httUrlRequest.callHttp(request: request, tag: ApiTag.TTS)

        }
        
    }
}

