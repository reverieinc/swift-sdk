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


import UIKit
/**
 * This the Class for Initiating Voice Search
 * Wrapper Class for initiating Voice Search with and Without UI
 */
public class StreamingSTT{
    
    
    private var withUi=false
    var apikey:String
    var appId:String
    var lang:String=""
    var domain:String=""
    var internalStreamingWrapper:StreamingInternalWrapper?
    var logging:String
    var noInputTimeout=2.0
    var silence=1.0
    var timeout=15.0
    
    
    
    
    ///Constructor call for RevVoiceSearch
    /// - Parameters:
    ///   - apikey:apikey provided to the client
    ///   - appId:appId provided to the client
    ///   - lang:lang of the voice search
    ///   - domain:domain of the voice search
    public  init( apikey: String, appId: String, lang:String,domain: String,logging:String) {
        
        self.apikey=apikey
        self.appId = appId
        self.lang=lang
        self.domain = domain
        self.logging=logging
       
        //networkMonitor.startMonitoring()
        
        
    }
    
    ///Constructor call for RevVoiceSearch
    /// - Parameters:
    ///   - apikey:apikey provided to the client
    ///   - appId:appId provided to the client
    public init( apikey: String, appId: String,logging:String) {
        
        self.apikey = apikey
        self.appId = appId
        self.logging=logging
        
        //networkMonitor.startMonitoring()
        
        
    }
    
    public func setNoInputTimeout(noInputTimeout:Double)
    {
        
        self.noInputTimeout=noInputTimeout
        
    }
    
    public func setSilence(silence:Double)
    {
        
        self.silence=silence
    }
    
    public func setTimeout(timeout:Double)
    {
        self.timeout=timeout
        
    }
    /// This function is used to start Voice Search
    /// - Parameters:
    ///   - viewController:Instance of current ViewController
    ///   - voiceInputDelegates:Listener attached to recieve callback
    ///   - isUIRequired:is pop UI required for search
    public func startRecognition(voiceInputDelegates:StreamingSTTDelegates,isUIRequired:Bool) {
        if(self.lang=="")
        {
            voiceInputDelegates.onError(data: "Language is Not Set for Voice Search")
            return
        }
        else if(self.domain=="")
        {
            voiceInputDelegates.onError(data: "Domain is Not set for Voice Search")
            return
            
            
        }
          
            
            
                if(!SttStreamingManager.inProcess)
                {  internalStreamingWrapper=StreamingInternalWrapper( apiKey: apikey, appId:appId, domain:domain , lang:lang,  voiceSearchDelegate:voiceInputDelegates,logging: logging,noInputTimeout: noInputTimeout,silence: silence,timeout: timeout)
                    internalStreamingWrapper?.startStreaming()}
                
            
            
        
    }
    
    /// This function is used to start Voice Search
    /// - Parameters:
    ///   - viewController:Instance of current ViewController
    ///   - voiceInputDelegates:Listener attached to recieve callback
    ///   - isUIRequired:is pop UI required for search:
    ///   - domain:domain of the Voice Search
    ///   - lang:language of the voice search
    public func startRecognition(voiceInputDelegates:StreamingSTTDelegates,isUIRequired:Bool,domain:String,lang:String) {
        
      
         
                
                internalStreamingWrapper=StreamingInternalWrapper( apiKey: apikey, appId:appId, domain:domain , lang:lang,  voiceSearchDelegate:voiceInputDelegates,logging: logging,noInputTimeout: noInputTimeout,silence: silence,timeout: timeout)
                internalStreamingWrapper?.startStreaming()
                
            
            
       
    }
    /// This function is stop the voice and get final instant result
    public func finishInput()
    {
        internalStreamingWrapper?.stopStreamingForFinal()
    }
    
    ///  This function is stop the voice and kill the voice search without Result
    public func cancel()
    {
        internalStreamingWrapper?.stopStreaming()
        
    }
    
    public func setApiDebug(status : Bool)
    {
        Log.EXTERNAL_DEBUG = status 
        
        
    }
    
}
