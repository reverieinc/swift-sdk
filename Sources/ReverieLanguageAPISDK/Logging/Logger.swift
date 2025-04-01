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
/// Wrapper of logger to toggle logging from client side
class Logger{
    
    static func printLog(string:Any)
    {
        if(Log.VERBOSE)
        {
            
            let stringValue = String(describing: string)
            
            let originalString = stringValue
            let utf8Data = originalString.data(using: .utf8)

            
            if let utf8Data = utf8Data {
        
                
                let bodyString = String(data:utf8Data, encoding: .utf8)
                print("SDK Logger: \(String(describing: bodyString))")
               
            } else {
                print("Error converting string to UTF-8")
            }
        
        }
        
    }
    
}
