/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DataTransaction : Codable {
	let transactionId : String?
	let amount : Double?
	let transactionDate : String?
	let description : String?
	let transactionType : String?
	let receipient : Receipient?

	enum CodingKeys: String, CodingKey {

		case transactionId = "transactionId"
		case amount = "amount"
		case transactionDate = "transactionDate"
		case description = "description"
		case transactionType = "transactionType"
		case receipient = "receipient"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		transactionDate = try values.decodeIfPresent(String.self, forKey: .transactionDate)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
		receipient = try values.decodeIfPresent(Receipient.self, forKey: .receipient)
	}

}
