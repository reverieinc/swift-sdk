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

/// Class to initiate Voice Search WIthout UI
class StreamingInternalWrapper:StreamingInternalDelegate{
   
    
    func onResult(data: String)
    {
        if let jsonData = data.data(using: .utf8) {
            do {
                // Decode JSON data into a Person struct
                let voiceSearchData = try JSONDecoder().decode(StreamingResultData.self, from: jsonData)
                if(voiceSearchData.final)
                {
                    StreamingInternalWrapper.inProcess=false
                }
                
                DispatchQueue.main.async{
                    self.voiceSearchDelegate.onResult(data: voiceSearchData)
                    Logger.printLog(string:data)
                }
            } catch {
                Logger.printLog(string:"Error decoding JSON: \(error)")
            }
        } else {
            Logger.printLog(string:"Error converting JSON string to data")
        }
        
        
        
    }
    
    func onError(data: String) {
        self.voiceSearchDelegate.onError(data: data)
        StreamingInternalWrapper.inProcess=false
    }
    
    func onStartRecording(isTrue: Bool) {
        self.voiceSearchDelegate.onRecordingStart(isTrue: isTrue)
        DispatchQueue.main.async {
            Logger.printLog(string:"Recording\(isTrue)")
        }
        
    }
    func onEndRecording(isTrue: Bool) {
        self.voiceSearchDelegate.onRecordingEnd(isTrue: isTrue)
        StreamingInternalWrapper.inProcess=false
    }
    var apiKey:String
    var appId:String
    var domain:String
    var lang:String
    var voiceSearchDelegate:StreamingSTTDelegates
    var sttStreaming:SttStreamingManager
    static var inProcess: Bool = false
    var isStreaming=false
    var logging:String
    
    init(apiKey: String, appId: String, domain: String, lang: String, voiceSearchDelegate: StreamingSTTDelegates,logging:String,noInputTimeout:Double,silence:Double,timeout:Double) {
        self.apiKey = apiKey
        self.appId = appId
        self.domain = domain
        self.lang = lang
        self.logging=logging
        self.voiceSearchDelegate = voiceSearchDelegate
        sttStreaming=SttStreamingManager(appId: appId, apiKey: apiKey, domain:domain , lang:lang,logging: logging)
        sttStreaming.setSilence(silence: silence)
        sttStreaming.setNoInputTimeout(noInputTimeout: noInputTimeout)
        sttStreaming.setTimeout(timeout: timeout)
        sttStreaming.setDelegate(delegate: self)
    }
    
    func startStreaming()
    {   if(!StreamingInternalWrapper.inProcess){
        isStreaming=true
        sttStreaming.startStreaming()
        StreamingInternalWrapper.inProcess=true
    }
        
    }
    func stopStreamingForFinal()
    {    StreamingInternalWrapper.inProcess=false
        if(isStreaming)
        {Logger.printLog(string: "Stoping Final")
            sttStreaming.stopStreamingForFinal()
            isStreaming=false
        }
    }
    func stopStreaming()
    {   StreamingInternalWrapper.inProcess=false
        if(isStreaming)
        {   Logger.printLog(string: "Stoping")
            sttStreaming.stopStreaming()
            isStreaming=false
            
        }
        
        
    }
    
}
