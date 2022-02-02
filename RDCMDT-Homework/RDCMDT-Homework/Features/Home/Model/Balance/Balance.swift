//
//  Balance.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation

struct Balance : Codable{
    var status : String = ""
    var accountNo : String?
    var balance : Double?
    var error : String?
}
