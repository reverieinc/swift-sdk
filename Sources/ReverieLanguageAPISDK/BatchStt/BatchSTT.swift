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

/// Class to initiate BatchSTT
public class BatchSTT:HttpUrlRequestDelegates{
    func onResult(data: Data, tag: String) {
        if(tag==ApiTag.BATCH_UPLOAD)
        {
            //  self.batchSttDelegates?.onResultUpload(data: <#T##BatchUploadData#>)
            do {
                let resultJson = try JSONDecoder().decode(BatchUploadData.self, from: data)
                
                Logger.printLog(string:"Sucess Upload")
                DispatchQueue.main.async {
                    self.batchSttDelegates?.onResultUpload(data: resultJson)
                }
                
            }
            catch{
                Logger.printLog(string:"\(error)")
                
            }
            
        }
        else if(tag==ApiTag.BATCH_STATUS)
        {
            
            do {
                let resultJson = try JSONDecoder().decode(BatchStatusData.self, from: data)
                
                Logger.printLog(string:"Success Status")
                DispatchQueue.main.async {
                    self.batchSttDelegates?.onResultStatus(data: resultJson)
                }
            }
            catch{
                Logger.printLog(string:"\(error)")
                
            }
        }
        else if(tag==ApiTag.BATCH_TRANSCRIPT)
        {
            do {
                let resultJson = try JSONDecoder().decode(BatchTranscriptResult.self, from: data)
                
                Logger.printLog(string:"Success Transcript")
                DispatchQueue.main.async {
                    self.batchSttDelegates?.onResultTranscript(data: resultJson)
                }
            }
            catch{
                Logger.printLog(string:"\(error)")
                
            }
            
        }
    }
    
    func onError(error: String, tag: String,errorTag :Int) {
        self.batchSttDelegates?.onError(error: error,errorTag: errorTag)
    }
    
    private var appId:String
    private var apiKey:String
    private var batchSttDelegates:BatchSttDelegates?
    private var format:String=""
    public init(appId: String, apiKey: String) {
        self.appId = appId
        self.apiKey = apiKey
    }
    public func setFormat(format:String)
    {
        self.format=format
        
    }
    
    
    /// Set the Batch  Delegate Callback
    /// - Parameter batchSttDelegates: instance of BatchSttdelegates
    public func setBatchDelegates(batchSttDelegates:BatchSttDelegates)
    {
        self.batchSttDelegates = batchSttDelegates
        
    }
    
    /// Function to upload fie via FileURL
    /// - Parameters:
    ///   - fileURL: fileurl of the selected file
    ///   - domain: domain in which Batch STT is needed
    ///   - language: language of the content
    public func upload(fileURL:URL,domain:String,language:String)
    { Logger.printLog(string:"Called")
        //  self.batchSttDelegates=batchSttDelegates
        if (fileURL.startAccessingSecurityScopedResource())// to access scoped file URI
        {
            guard let url = URL(string: "\(Constants.HTTP_URL)upload") else {
                Logger.printLog(string:"Invalid URL")
                self.batchSttDelegates?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
                return
            }
            let boundary = UUID().uuidString
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.addValue(self.apiKey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
            request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
            request.addValue(language, forHTTPHeaderField: "src_lang")
            request.addValue(domain, forHTTPHeaderField: "domain")
            request.addValue("stt_batch", forHTTPHeaderField: RequestHeaderTag.RevAppName)
            if(!(format==""))
            {
                request.addValue(format, forHTTPHeaderField: "format")
            }
            var body = Data()
            let fieldName = "file"
            
            do {
                let fileData = try Data(contentsOf: fileURL)
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(fieldName)\";filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using:.utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
            } catch {
                Logger.printLog(string:"An error occurred: \(error)")
                self.batchSttDelegates?.onError(error: error.localizedDescription,errorTag: ErrorTag.SDK_ERROR)
                return
            }
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            // Set the request body
            request.httpBody = body
            let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
            httUrlRequest.callHttp(request: request, tag: ApiTag.BATCH_UPLOAD)
            
            
        }
        else{
            
            self.batchSttDelegates?.onError(error: "Unable to start Scoped Storage Access Please Provide Relevant Permissions ",errorTag: ErrorTag.SDK_ERROR)
            
        }
    }
    
    /// Check Sta
    /// - Parameters:
    ///   - jobId: jobid recieved from the response of upload function
    ///   - batchSttDelegates: instance of delegate
    public func checkStatus(jobId:String)
    {
        
        
        
        guard let url = URL(string: "\(Constants.HTTP_URL)status?job_id=\(jobId)") else {
            Logger.printLog(string:"Invalid URL")
            self.batchSttDelegates?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.apiKey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
        request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
        request.addValue("stt_batch", forHTTPHeaderField: RequestHeaderTag.RevAppName)
        
        
        let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
        httUrlRequest.callHttp(request: request, tag: ApiTag.BATCH_STATUS)
        
        
        
    }
    
    
    public func getTranscript(jobId:String)
    {
        
        guard let url = URL(string: "\(Constants.HTTP_URL)transcript?job_id=\(jobId)") else {
            Logger.printLog(string:"Invalid URL")
            self.batchSttDelegates?.onError(error:"Invalid URL",errorTag: ErrorTag.SDK_ERROR)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(self.apiKey, forHTTPHeaderField: RequestHeaderTag.RevApiKey)
        request.addValue(self.appId, forHTTPHeaderField: RequestHeaderTag.RevAppId)
        request.addValue("stt_batch", forHTTPHeaderField: RequestHeaderTag.RevAppName)
        let httUrlRequest = HttpUrlRequest(urlRequestDelegate: self)
        httUrlRequest.callHttp(request: request, tag: ApiTag.BATCH_TRANSCRIPT)
    }
    
    
    
}
