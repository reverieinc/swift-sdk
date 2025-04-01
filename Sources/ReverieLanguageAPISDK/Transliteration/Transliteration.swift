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
/// Class to initiate Transliteration Call
public class Transliteration: HttpUrlRequestDelegates{
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.TRANSLITERATION)
        { do{  let resultJson =  try JSONDecoder().decode(TransliterationResponse.self, from: data)
            self.transliterationDelegate?.onResult(data: resultJson)
            Logger.printLog(string: "Success Transliteration")
        }
            catch{
                 Logger.printLog(string:"\(error)")
                
            }
        }
    }
    
    func onError(error: String, tag: String,errorTag:Int) {
        if(tag==ApiTag.TRANSLATION)
        {  self.transliterationDelegate?.onError(error: error,errorTag: errorTag)}
        
    }
    
    struct RequestBody: Encodable {
        let data: [String]
        let isBulk: Bool?
        let ignoreTaggedEntities: Bool?
        let noOfSuggestions: Int?
        let abbreviate :Bool?
        let convertNumber:String?
        let convertRoman:Bool?
        let convertOrdinal:Bool?
        let abbreviationWithoutDot:Bool?
        
    }
    
    private var apikey:String=""
    private var appId:String=""
    private var transliterationDelegate:TransliterationDelegate?
    private var noOfSuggestion:Int? = nil
    private var abbreviate:Bool? = nil
    private var isBulk: Bool? = nil
    private var ignoreTaggedEntities: Bool? = nil
    private var convertNumber:String? = nil
    private var convertRoman:Bool? = nil
    private var convertOrdinal:Bool? = nil
    private var abbreviationWithoutDot:Bool? = nil
    
    public func setNoOfSuggestion(noOfSuggestions:Int)
    {
        self.noOfSuggestion = noOfSuggestions
        
    }
    public func setAbbreviate(abbreviate:Bool)
    {
        self.abbreviate = abbreviate
        
    }
    public func setIsBulk(isBulk:Bool)
    {
        self.isBulk = isBulk
        
    }
    public func setIgnoreTaggedEntities(ignoreTaggedEntities:Bool)
    {
        self.ignoreTaggedEntities=ignoreTaggedEntities
        
    }
    public func setConvertNumber(convertNumber:String)
    {
        self.convertNumber = convertNumber
        
    }
    public func setConvertRoman(convertRoman:Bool)
    {
        
        self.convertRoman = convertRoman
        
    }
    public func setConvertOrdinal(convertOrdinal:Bool)
    {
        
        self.convertOrdinal = convertOrdinal
        
    }
    
    public func setAbbreviationWithoutDot(abbreviationWithoutDot:Bool)
    {
        self.abbreviationWithoutDot = abbreviationWithoutDot
        
    }
    ///
    /// - Parameters:
    ///   - apikey: apikey for transliteration
    ///   - appId: appid for transliteration
    public  init(apikey: String, appId: String) {
        self.apikey = apikey
        self.appId = appId
        return
        
    }
    
    public func setTransliterationDelegate(delegate:TransliterationDelegate)
    {
        self.transliterationDelegate=delegate
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - data: a list of strings needed to be transliterated
    ///   - srcLang: language of the list of strings
    ///   - tgtLang: target language of transliteration
    ///   - domain: domain of transliteration
    ///   - cntLang: same as srclang
    public func transliterate(srcLang:String,tgtLang:String,domain:String,cntLang:String,_ data:String ...) {
        var textData : [String]
        
        textData=[]
        textData.append(contentsOf: data)
        guard let url = URL(string: "\(Constants.HTTP_URL)") else {
             Logger.printLog(string:"Invalid URL")
            self.transliterationDelegate?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
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
        request.addValue("transliteration", forHTTPHeaderField: RequestHeaderTag.RevAppName)
        // Create JSON reis
        
        let requestBody = RequestBody(data: textData, isBulk: isBulk, ignoreTaggedEntities:ignoreTaggedEntities,noOfSuggestions: noOfSuggestion,abbreviate: abbreviate,convertNumber: convertNumber,convertRoman: convertRoman,convertOrdinal: convertOrdinal,abbreviationWithoutDot: abbreviationWithoutDot)
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
             Logger.printLog(string:"Error creating JSON request body: \(error.localizedDescription)")
            self.transliterationDelegate?.onError(error:error.localizedDescription,errorTag: ErrorTag.SDK_ERROR)
            return
        }
        let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
        httUrlRequest.callHttp(request: request, tag: ApiTag.TRANSLITERATION)

        
        
    }
    
    
    
}
