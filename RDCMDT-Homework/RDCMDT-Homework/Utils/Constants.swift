//
//  Constants.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation
struct Constants {
    
    struct Urls {
        
        // MARK: All POST
        static func baseURLWithParam(params : String) -> URL {
            return URL(string: "https://green-thumb-64168.uc.r.appspot.com\(params)")!
        }
        
        static func urlForUpdateDelete(id: String) -> URL {
            return URL(string: "https://limitless-forest-49003.herokuapp.com/posts/\(id)")!
        }
    }
        
}
