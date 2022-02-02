//
//  RegisterViewModel.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation



class RegisterViewModel {
    init() {
    }
    
    func registerNewUser(username: String, password : String, completion: @escaping (String, String) -> Void) {
        let json: [String: Any] = ["username": username,
                                   "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/register"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        print("ADD NEW POST DATA FROM JSON :\(json) : \(urlRequest)")
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(User.self, from: postResult)
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion("ERROR", errorMessage)
                        }
                    }else if (dataDecoder.status == "success"){
                        if let token = dataDecoder.token{
                            print("TOKEN SET")
                            print("user token : \(token)")
                            completion("SUCCESS", token)
                        }
                        
                        
                    }
                    
                  } catch let parsingError {
                      
                     print("Error", parsingError)
                      completion("ERROR", "\(parsingError)")
                }
            }
        }
        
    }
    
}
