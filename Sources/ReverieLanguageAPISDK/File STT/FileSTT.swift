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

/// Class to Initiate FileSTT
public class FileSTT:HttpUrlRequestDelegates{
    
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.FILE_STT)
        {do{
            let resultJson = try JSONDecoder().decode(FileSTTResponseData.self, from: data)
        
             Logger.printLog(string:"Sucess Upload File")
           
                self.fileSTTDelegates?.onResult(data: resultJson)
            
        }
            catch{
                 Logger.printLog(string:"\(error)")
            }
        }
    }
    
    func onError(error: String, tag: String,errorTag:Int) {
        if(tag==ApiTag.FILE_STT)
        {
            self.fileSTTDelegates?.onError(error: error,errorTag:errorTag)
        }
    }
    
    
    
    private var appId:String
    private var apiKey:String
    private var fileSTTDelegates:FileSTTDelegates?
    private var format:String = ""
    private var logging:String = ""
    ///Constructor call
    public init(appId: String, apiKey: String) {
        self.appId = appId
        self.apiKey = apiKey
    }
    /// Set the format (Optional)
    public func setFormat(format:String)
    {
        self.format=format
        
    }
    /// Set the Logging (Optional)
    public func setLogging(logging:String)
    {
        self.logging=logging
    }
    
    ///Set the Delegates(Mandatory befor calling the uploadfunction)
    public func setFileSttDelegates(delegate:FileSTTDelegates)
    {
       
        DispatchQueue.main.async {
            print("Setting Delegates")
            self.fileSTTDelegates = delegate
        }
      
    }
    /// Function to upload the file using fileURL
    /// - Parameters:
    ///   - fileURL: FileUrl of the file uploaded
    ///   - domain: domain needed for stt
    ///   - language: language of speech
    public func upload(fileURL:URL,domain:String,language:String)
    {
       // self.fileSTTDelegates=fileSttDelegates
        if (fileURL.startAccessingSecurityScopedResource()){
            guard let url = URL(string: "\(Constants.HTTP_URL)") else {
                 Logger.printLog(string:"Invalid URL")
                self.fileSTTDelegates?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
                return
            }
            let boundary = UUID().uuidString

            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
           
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(self.apiKey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
            request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
            request.addValue(language, forHTTPHeaderField: "src_lang")
            request.addValue(domain, forHTTPHeaderField: "domain")
            request.addValue("stt_file", forHTTPHeaderField: RequestHeaderTag.RevAppName)
            if(!(format==""))
            {
                request.addValue(format, forHTTPHeaderField: "format")
            }
            if(!(logging==""))
            {
                request.addValue(logging, forHTTPHeaderField: "logging")
                
            }
            
            var body = Data()
            let fieldName = "audio_file"
            // Append the file data to the body
            do {
                let fileData = try Data(contentsOf: fileURL)
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(fieldName)\";filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using:.utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
            } catch {
                 Logger.printLog(string:"An error occurred: \(error)")
                 self.fileSTTDelegates?.onError(error:error.localizedDescription,errorTag: ErrorTag.SDK_ERROR)
                return
            }
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            // Set the request body
            request.httpBody = body
            let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
            httUrlRequest.callHttp(request: request, tag: ApiTag.FILE_STT)
            
            
        }
        else{
            self.fileSTTDelegates?.onError(error:"Unable to start Scoped Storage Access Please Provide Relevant Permissions ",errorTag: ErrorTag.SDK_ERROR)
            
            
        }
        
    }
    
}
