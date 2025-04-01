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
///Manages Http Calls using request body (SDK Internal Usages)
class HttpUrlRequest{
    
    private var urlRequestDelegate :HttpUrlRequestDelegates
    
    
    init(urlRequestDelegate: HttpUrlRequestDelegates) {
        self.urlRequestDelegate = urlRequestDelegate
    }
    
    
    func callHttp(request:URLRequest,tag:String)
    {
        if let body = request.httpBody,
        let bodyString = String(data: body, encoding: .utf8) {
            Logger.printLog(string: "HTTP Body: \(bodyString)")
    } else {
      
    }
        Logger.printLog(string:request.allHTTPHeaderFields as Any)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                self.urlRequestDelegate.onError(error: error?.localizedDescription ?? "", tag: tag,errorTag: ErrorTag.SDK_ERROR)
                Logger.printLog(string:"Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            
            guard let httpResponse = response as? HTTPURLResponse else {
                 Logger.printLog(string:"Invalid HTTP ")
                return
            }
         
                if(httpResponse.statusCode>=200&&httpResponse.statusCode<300)
                {    if let jsonString = String(data: data, encoding: .utf8) {
                     Logger.printLog(string:"JSON Response: \(jsonString)")
                    guard response is HTTPURLResponse else {
                       Logger.printLog(string:"Invalid HTTP ")
                        return
                    }
                }

                    
                  Logger.printLog(string:"Sucess")
                    DispatchQueue.main.async{
                        self.urlRequestDelegate.onResult(data: data,tag: tag)
                    }
                    
                }
                else{
                    
                    let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    DispatchQueue.main.async {
                        self.urlRequestDelegate.onError(error:"{responseCode : "+String(httpResponse.statusCode)+",responseMessage:"+message+"}",tag: tag,errorTag: ErrorTag.API_ERROR)
                    }
                            Logger.printLog(string:httpResponse.statusCode)
                            Logger.printLog(string:message)
                }
            
            
        }
        .resume()
        
        
        
    }
    
}
