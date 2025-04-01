# Transliteration
Transliteration is the process of converting texts from one script to another based on phonetic similarity. Here, the text is displayed in alphabets of different languages, but the pronunciation, grammar, and sense of the original version remain intact in these new characters. 
Transliteration is involved while converting the names, addresses, titles, and more into Indian languages as localization is important without changing meaning. For a better understanding, refer to the below examples:
> **Note: On the basis of the selected [domain](#supporting-domains) the result will vary**

| Type        | English Script | Hindi Script   |
|-------------|----------------|----------------|
| City Name   | New Delhi      | न्यू दिल्ली    |
| Brand       | Bata           | बाटा           |
| Person Name | AR Rahaman     | ए आर रहमान     |

### Supporting Languages
Transliteration API supports 22 Indic languages, including Rare languages. It converts scripts from English to 22 Indic languages and 12 Indic languages to English. It also transliterates scripts from one regional language to another (for example: Hindi to Tamil). 

| Language Name | Language Code | Language Name | Language Code |
|---------------|---------------|---------------|---------------|
| Hindi         | hi            | Odia          | or            |
| Assamese      | as            | Punjabi       | pa            |
| Bengali       | bn            | Tamil         | ta            |
| Kannada       | kn            | Telugu        | te            |
| Malayalam     | ml            | English       | en            |
| Marathi       | mr            | Urdu          | ur            |
| Konkani       | kom           | Sindhi        | sd            |
| Dogri         | doi           | Bodo          | brx           |
| Kashmiri      | ks            | Maithili      | mai           |
| Manipuri      | mni           | Sanskrit      | sa            |
| Santhali      | sat           | Gujarati      | gu            |



### Supporting Domains


| Domain Name              | SDK Constant                                          |
|--------------------------|-------------------------------------------------------| 
| Default                  | `TransliterationDomain.DEFAULT`                       |
| Names                    | `TransliterationDomain.NAMES`                         |
| OnlyEnglish              | `TransliterationDomain.ONLY_ENGLISH`                  |
| Cricketers               | `TransliterationDomain.CRICKETERS`                    |
| Banking                  | `TransliterationDomain.BANKING`                       |
| Brands                   | `TransliterationDomain.BRANDS`                        |
| Addresses                | `TransliterationDomain.ADDRESSES`                     |
| NumberInWords            | `TransliterationDomain.NUMBER_IN_WORDS`               |
| Food                     | `TransliterationDomain.FOOD`                          |
| Media & Entertainment    | `TransliterationDomain.MEDIA_AND_ENTERTAINMENT`       |
| Grocery                  | `TransliterationDomain.GROCERY`                       |
| Healthcare               | `TransliterationDomain.HEALTH_CARE`                   |
| Enterprise               | `TransliterationDomain.ENTERPRISE`                    |



> To understand the `Domains` better please refer to [Supporting Domains](https://docs.reverieinc.com/reference/transliteration-api#supporting-domains)






## SDK usage example:

                                                                  
### Swift based example implementation of the SDK:

1. Prepare the constructor: 
     ```sh 
       //selecting domain as Default
        domain: Int = TransliterationDomain.DEFAULT
        private var transliteration=Transliteration(apikey:API_KEY, appId: APP_ID)
    ```

2. Implement the Delegates in the Struct or Class for getting the results. 
    ```sh 
        struct Transliteration_UI: View, TransliterationDelegate {
        
        func onResult(data: TransliterationResponse) {
            output =  data.responseList.first?.outString.first?.lowercased() ?? ""
        }   
    
        func onError(error: String) {
            output=error
        }
               
    ```
3. Attach the Delegates to the Transliteration Class
    ```sh
        transliteration.setTransliterationDelegate(delegate: self)// attach this after init in case of ViewController and after onAppear in Case of Swiftui
    ```

4.  Call the Transliterate Function
    ```sh
    
        transliteration.transliterate( srcLang: sourceLanguage, tgtLang: targetLanguage, domain: TransliterationDomain.CRICKETERS, cntLang:sourceLanguage,textInput)// last param is variable argument to provide multiple string to SDK for transliteration
        
    ```
8. To Set the IgnoreTaggedEntities(Optional)
    ```sh
    transliteration.setIgnoreTaggedEntities(ignoreTaggedEntities: true)
    ```

9. To Set the ConvertNumber(Optional)
    ```sh
    transliteration.setConvertNumber(convertNumber: true)
    ```

10. To Set the ConvertRoman(Optional)
    ```sh
    transliteration.setConvertRoman(convertRoman: true)
    ```

11. To Set the ConvertOrdinal(Optional)
    ```sh
    transliteration.setConvertOrdinal(convertOrdinal: true)
    ```

12. To Set the AbbreviationWithoutDot(Optional)
    ```sh
    transliteration.setAbbreviationWithoutDot(abbreviationWithoutDot: true)
    ```
