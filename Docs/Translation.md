# Translation
Content Localization is the process of adapting the original content to a new target audience. The localization process requires more effort and skill than translation (e.g., changing measurement systems, adding or changing words to help a local reader). The translated text has to be simple, easy to understand, and capture subtle nuances and cultural references.
**Note: On the basis of the selected [domain](#supporting-domains) the result will vary**
The example below demonstrates how the Localization SDK  will analyze the content's domain & context and localize it:


| Source Content                            | Target Content                         |
|-------------------------------------------|----------------------------------------|
| Book 3 flight tickets to Delhi            | दिल्ली के लिए 3 फ्लाइट टिकट बुक करें   |
| I have read books written by Abdul Kalam. | मैंने अब्दुल कलाम की लिखी किताबें पढ़ी |

###  Supporting Languages




| Language  | Code | Language | Code |
|-----------|------|----------|------|
| Hindi     | hi   | Bengali  | bn   |
| Gujarati  | gu   | Kannada  | kn   |
| Tamil     | ta   | Punjabi  | pa   |
| Telugu    | te   | English  | en   |
| Marathi   | mr   | Assamese | as   |
| Malayalam | ml   | Odia     | or   |

### Supporting Domains

| Domain Name | SDK Constants                  |
|-------------|--------------------------------|
| General     | `TranslationDomains.GENERAL`   |
| Travel      | `TranslationDomains.TRAVEL`    |
| Ecommerce   | `TranslationDomains.ECOMMERCE` |
| Music       | `TranslationDomains.MUSIC`     |
| Banking     | `TranslationDomains.BANKING`   |
| Grocery     | `TranslationDomains.GROCERY`   |
| Education   | `TranslationDomains.EDUCATION` |
| Medical     | `TranslationDomains.MEDICAL`   |

To understand the `Domains` better please refer to [Supporting Domains](https://docs.reverieinc.com/reference/localization-api#supporting-domains)



## SDK usage example:
### Swift based example implementation of the SDK:

1. Prepare the constructor: 
     ```sh 
      
            private var translation=Translation(apikey:API_KEY, appId: APP_ID
    )
    ```

2. Implement the Delegates in the Struct or Class for getting the results. 
    ```sh 
        struct Translation_UI: View, TranslationDelegate {
        @Environment(\.presentationMode) var presentationMode
        func onResult(data: TranslationResponse) {
            output=data.responseList.first?.outString ?? ""
        }
    
    
        func onError(error: String) {
            output=error
        }
               
    ```
3. Attach the Delegates to the Translation Class
    ```sh
        translation.setTranslationDelegate(delegate: self) // attach this after init in case of ViewController and after onAppear in Case of Swiftui
    ```

4.  Call the Translation Function
    ```sh
         translation.translate(srcLang: sourceLanguage, tgtLang: targetLanguage, domain: TranslationDomain.GENERAL, cntLang:sourceLanguage,textInput)
        
    ```

5.  To Set the DBLookupParam(Optional)
    ```sh
    translation.setDBLookupParam(true)
    ```

6.  To Set the SegmentationParam(Optional)
    ```sh
    translation.setSegmentationParam(true)
    ```

7.  To Set the NmtParam(Optional)
    ```sh
    translation.setNmtParam(true)
    ```

8.  To Set the BuiltInPreProc(Optional)
    ```sh
    translation.setBuiltInPreProc(true)
    ```

9.  To Set the DebugMode(Optional)
    ```sh
    translation.setDebugMode(true)
    ```

10. To Set the UsePrabandhak(Optional)
    ```sh
    translation.setUsePrabandhak(true)
    ```

11. To Set the NmtMask(Optional)
    ```sh
    translation.setNmtMask(true)
    ```

12. To Set the NmtMaskTerms
    ```sh
    translation.setNmtMaskTerms("term1", "term2", "term3")
    ```

13. To Set the TranslationDelegate
    ```sh
    translation.setTranslationDelegate(delegate: delegateInstance)
    ```
