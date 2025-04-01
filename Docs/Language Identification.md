# Language Identification
This Api is used to detect or identify the language of the source content

## Supporting Language

| Languages in native script | Language in native script | 
|----------------------------|---------------------------|
| Assamese                   | Bengali                   | 
| Bengali                    | Gujarati                  | 
| English                    | Hindi                     | 
| Gujarati                   | Kannada                   | 
| Hindi                      | Marathi                   |   
| Malayalam                  | Telugu                    | 
| Marathi                    |                           |
| Odia                       |                           |
| Punjabi                    |                           |
| Tamil                      |                           |
| Telugu                     |                           |



## Mandatory Parameters
| Parameters | Type    | Description                        |
|------------|---------|------------------------------------|
| text       | String  | Input text for language detection. |

## Optional Parameters
| Parameters | Type | Description                               | swift Code                   | 
|------------|------|-------------------------------------------|-----------------------------|
| max_length | int  | [Description](#Description-of-Parameters) | `instance.setMaxLength(2);` |

## Description of Parameters
1. **max_length**:Length of the string to be processed for tokenization. It should be a number in the power of 2(i.e, 16 = 2^4, 32 = 2^5 ..). Max value could be 512.

## SDK usage example:

                                                                  
### Swift based example implementation of the SDK:


1. Preparing the constructor.
      ```
         var languageDetect = LanguageIdentification(appId: "", apiKey:"" )
           
 

      ```
2. Implementing the listeners for handling the response:
    ```
    struct LanguageIdentificationUI: View,LanguageIdentificationDelegate {
    func onResult(data: ReverieLanguageAPISDK.LanguageIndetificationData) {
        output = data.lang
        
    }
    
    func onError(error: String, errorTag: Int) {
        
    }
       
                
    ```
   
3. Provide the input text for identification
    ```
              languageDetect.identifyLanguage(text:"String")
          
    ````

