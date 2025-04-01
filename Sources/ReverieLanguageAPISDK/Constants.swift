
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
struct Constants{
    static let STREAM_URL="wss://revapi.reverieinc.com/stream"
    static let INTENT_API_KEY = "api_key"
    static let INTENT_APP_ID = "app_id"
    static let INTENT_DOMAIN = "domain"
    static let INTENT_LANG = "lang"
    static let INTENT_LOGGING = "logging"
    static let HTTP_URL="https://revapi.reverieinc.com/"
    static let WARNING_NO_INTERNET = "No Internet Connection."
}
struct RequestHeaderTag{
    static let RevApiKey =  "REV-API-KEY"
    static let RevAppId = "REV-APP-ID"
    static let RevAppName =    "REV-APPNAME"
}
struct JsonLabels
{
    static let id = "id"
    static let success = "success"
    static let text = "text"
    static let final = "final"
    static let confidence = "confidence"
    static let cause = "cause"
    static let display_text = "display_text"
    
    
}
struct ApiTag{
    
    static let FILE_STT = "file_stt"
    static let TRANSLITERATION = "transliteration"
    static let TRANSLATION = "translation"
    static let TTS =  "tts"
    static let BATCH_UPLOAD = "upload"
    static let BATCH_STATUS = "status"
    static let BATCH_TRANSCRIPT = "transcript"
    static let LANGUAGE_IDENTIFICATION = "lang_id"
    
    
}
public struct SpeechToTextDomain{
    public static let VOICE_SEARCH = "voice_search"
    public static let GENERIC="generic"
    public static let BFSI="bfsi"
    public static let APP_SEARCH="app_search"
}
//TODO rename this struct name
public struct SttLogging{
    public static let TRUE="true"
    public static let FALSE="false"
    public static let NO_AUDIO="no_audio"
    public static let NO_TRANSCRIPT="no_transcript"
}

public struct Languages{
    public static let HINDI = "hi"
    public static let ASSAMESE = "as"
    public static let BENGALI = "bn"
    public static let GUJARATI = "gu"
    public static let KANNADA = "kn"
    public static let MALAYALAM = "ml"
    public static let MARATHI = "mr"
    public static let ODIA = "or"
    public static let PUNJABI = "pa"
    public static let TAMIL = "ta"
    public static let TELUGU = "te"
    public static let ENGLISH = "en"
}
public struct Speaker{
    
    public static let ENGLISH_FEMALE="en_female"
    public static let HINDI_FEMALE="hi_female"
    public static let HINDI_MALE="hi_male"
    public static let ODIA_MALE="or_male"
    public static let ODIA_FEMALE="or_female"
    public static let BENGALI_MALE="bn_male"
    public static let BENGALI_FEMALE="bn_female"
    public static let KANNADA_MALE="kn_male"
    public static let KANNADA_FEMALE="kn_female"
    public static let MALAYALAM_MALE="ml_male"
    public static let MALAYALAM_FEMALE="ml_female"
    public static let TAMIL_MALE="ta_male"
    public static let TAMIL_FEMALE="ta_female"
    public static let TELUGU_MALE="te_male"
    public static let TELUGU_FEMALE="te_female"
    public static let GUJARATI_MALE="gu_male"
    public static let GUJARATI_FEMALE="gu_female"
    public static let ASSAMESE_MALE="as_male"
    public static let ASSAMESE_FEMALE="as_female"
    public static let MARATHI_MALE="mr_male"
    public static let MARATHI_FEMALE="mr_female"
    public static let PUNJABI_MALE="pa_male"
    public static let PUNJABI_FEMALE="pa_female"
    
}
public struct TranslationDomain {
    
    public static let GENERAL = "1"
    public static let TRAVEL = "2"
    public static let ECOMMERCE = "3"
    public static let MUSIC = "4"
    public static let BANKING = "5"
    public static let GROCERY = "6"
    public static let EDUCATION = "7"
    public static let MEDICAL = "8"
}

public  struct TransliterationDomain {
    
    public static let  DEFAULT = "1"
    public static let  NAMES = "2"
    public static let  ONLY_ENGLISH = "4"
    public static let  CRICKETERS = "5"
    public static let  BANKING = "6"
    public static let  BRANDS = "7"
    public static let  ADDRESSES = "9"
    public static let  NUMBER_IN_WORDS="10"
    public static let  FOOD = "22"
    public static let  MEDIA_AND_ENTERTAINMENT = "25"
    public static let  GROCERY = "26"
    public static let  HEALTH_CARE="27"
    public static let  ENTERPRISE="28"
}

public struct ErrorTag{
    public static let SDK_ERROR = 0 //Error occured from SDK End
    public static let API_ERROR = 1 //Error occured from API End
    
}
