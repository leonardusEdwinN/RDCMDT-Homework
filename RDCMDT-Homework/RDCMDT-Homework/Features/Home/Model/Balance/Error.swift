//
//  Error.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 03/02/22.
//

import Foundation
struct Error : Codable {
    let name : String?
    let message : String?
    let expiredAt : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case message = "message"
        case expiredAt = "expiredAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        expiredAt = try values.decodeIfPresent(String.self, forKey: .expiredAt)
    }

}
