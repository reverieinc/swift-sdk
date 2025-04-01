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
///Data Structures for Batch Stt Transcript Api call
public struct BatchTranscriptResult: Codable {
    public let code: String
    public let job_id: String
    public let message: String
    public let result: TranscriptChannel
}

public struct TranscriptChannel: Codable {
    public let channel_number: Int
    public let transcript: String
    public let words: [[Word]] // Nested array of words

    private enum CodingKeys: String, CodingKey {
        case channel_number, transcript, words
    }
}

public struct Word: Codable {
    public let conf: Double
    public let end: Double
    public let start: Double
    public let word: String
}
