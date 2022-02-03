//
//  Register.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation
struct User: Codable{
    var status : String = ""
    var token : String?
    var error : String?
    var username: String?
    var accountNo: String?
}
