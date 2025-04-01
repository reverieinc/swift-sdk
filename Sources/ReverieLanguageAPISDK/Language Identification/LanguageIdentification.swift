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
public class LanguageIdentification:HttpUrlRequestDelegates
{
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.LANGUAGE_IDENTIFICATION)
        {
            do{
                let value = try JSONDecoder().decode(LanguageIndetificationData.self, from: data)
                languageDelegate?.onResult(data: value)}
            catch{
                
                languageDelegate?.onError(error: "Unable to Parse Json \(data.base64EncodedString())", errorTag: ErrorTag.SDK_ERROR)
            }
            
        }
    }
    
    func onError(error: String, tag: String, errorTag: Int) {
        if (tag == ApiTag.LANGUAGE_IDENTIFICATION)
        {
            languageDelegate?.onError(error: error, errorTag:errorTag)
            
        }
    }
    private var appId:String
    private var apiKey:String
    private var maxLen:Int?
    
   public  init(appId: String, apiKey: String) {
        self.appId = appId
        self.apiKey = apiKey
    }
    private var languageDelegate:LanguageIdentificationDelegate?
    
    public func setDelegate(languageDelegate:LanguageIdentificationDelegate)
    {
        self.languageDelegate=languageDelegate
    }
    
    struct RequestBodyLanguageIndetification: Encodable {
        let text:String
        let max_length:Int?
        
        
    }
    public func setMaxLength(maxLen:Int)
    {
        self.maxLen = maxLen
        
    }
    public func identifyLanguage(text:String)
    {
        guard let url = URL(string: "\(Constants.HTTP_URL)") else {
             Logger.printLog(string:"Invalid URL")
            self.languageDelegate?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.apiKey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
        request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
        
        request.addValue("lang_id_text", forHTTPHeaderField: RequestHeaderTag.RevAppName)
        
        do{
            request.httpBody = try JSONEncoder().encode(   RequestBodyLanguageIndetification(text: text, max_length: self.maxLen))
            let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
            httUrlRequest.callHttp(request: request, tag: ApiTag.LANGUAGE_IDENTIFICATION)
            
            
        }
        catch{
            
            
        }
        
        
    }
    
}

