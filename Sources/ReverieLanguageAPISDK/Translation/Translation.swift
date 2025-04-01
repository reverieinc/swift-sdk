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


public class Translation: HttpUrlRequestDelegates{
    struct RequestBody: Encodable {
        let data: [String]
        let dbLookupParam : Bool?
        let segmentationParam : Bool?
        let nmtParam : Bool?
        let builtInPreProc : Bool?
        let debugMode : Bool?
        let usePrabandhak : Bool?
        let nmtMask : Bool?
        let nmtMaskTerms : [String]?
        
        
        
        
    }
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.TRANSLATION)
        {
            do{  let resultJson =  try JSONDecoder().decode(TranslationResponse.self, from: data)
                self.translationDelegate?.onResult(data: resultJson)
                Logger.printLog(string: "Success Translation")
            }
            catch{
                 Logger.printLog(string:"\(error)")
                
            }
            
        }
        
    }
    
    func onError(error: String, tag: String,errorTag:Int) {
        if(tag==ApiTag.TRANSLATION)
        {
            self.translationDelegate?.onError(error: error,errorTag:errorTag)
            
            
        }
    }
    
    
    
    
    private var dbLookupParam: Bool?
    private var segmentationParam: Bool?
    private var nmtParam: Bool?
    private var builtInPreProc: Bool?
    private var debugMode: Bool?
    private var usePrabandhak: Bool?
    private var nmtMask: Bool?
    private var nmtMaskTerms: [String]?
    private var apikey:String=""
    private var appId:String=""
    private var translationDelegate:TranslationDelegate?
    
    public init(apikey: String, appId: String) {
        self.apikey = apikey
        self.appId = appId
        
        return
        
    }
    public  func setDBLookupParam(_ newValue: Bool?) {
        dbLookupParam = newValue
    }
    
    public func setSegmentationParam(_ newValue: Bool?) {
        segmentationParam = newValue
    }
    
    public func setNmtParam(_ newValue: Bool?) {
        nmtParam = newValue
    }
    
    public func setBuiltInPreProc(_ newValue: Bool?) {
        builtInPreProc = newValue
    }
    
    public func setDebugMode(_ newValue: Bool?) {
        debugMode = newValue
    }
    
    public func setUsePrabandhak(_ newValue: Bool?) {
        usePrabandhak = newValue
    }
    
    public  func setNmtMask(_ newValue: Bool?) {
        nmtMask = newValue
    }
    
    public func setNmtMaskTerms(_ newValue: String...) {
        if nmtMaskTerms == nil {
            nmtMaskTerms = []
        }
        nmtMaskTerms?.append(contentsOf: newValue)
    }
    
    public func setTranslationDelegate(delegate:TranslationDelegate)
    
    {
        
        self.translationDelegate=delegate
        
        
    }
    
    
    public func translate(srcLang:String,tgtLang:String,domain:String,cntLang:String,_ data :String ...) {
        var textData : [String]
        
        textData=[]
        textData.append(contentsOf: data)
        
        
        guard let url = URL(string: "\(Constants.HTTP_URL)") else {
             Logger.printLog(string:"Invalid URL")
            self.translationDelegate?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.apikey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
        request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
        request.addValue(srcLang, forHTTPHeaderField: "src_lang")
        request.addValue(tgtLang, forHTTPHeaderField: "tgt_lang")
        request.addValue(domain, forHTTPHeaderField: "domain")
        request.addValue(cntLang, forHTTPHeaderField: "cn_lang")
        request.addValue("localization", forHTTPHeaderField: RequestHeaderTag.RevAppName)
        // Create JSON request body
        
        let requestBody = RequestBody(data: textData, dbLookupParam:dbLookupParam, segmentationParam: segmentationParam, nmtParam: nmtParam, builtInPreProc: builtInPreProc, debugMode: debugMode, usePrabandhak: usePrabandhak, nmtMask: nmtMask, nmtMaskTerms: nmtMaskTerms)
        textData.removeAll()
       
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
             Logger.printLog(string:"Error creating JSON request body: \(error.localizedDescription)")
            self.translationDelegate?.onError(error:error.localizedDescription,errorTag: ErrorTag.SDK_ERROR)
            return
        }
        let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
        httUrlRequest.callHttp(request: request, tag: ApiTag.TRANSLATION)
        
        
    }
    
    
    
    
}
