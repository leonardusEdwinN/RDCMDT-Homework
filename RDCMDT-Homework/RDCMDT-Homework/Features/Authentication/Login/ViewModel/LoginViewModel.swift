//
//  LoginViewModel.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation

class LoginViewModel {
    func login(username: String, password : String, completion: @escaping (String, String) -> Void) {
        let json: [String: Any] = ["username": username,
                                   "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/login"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(User.self, from: postResult)
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion("ERROR", errorMessage)
                        }
                    }else if (dataDecoder.status == "success"){
                        if let token = dataDecoder.token, let usernameLoggedIn = dataDecoder.username, let accountNumber = dataDecoder.accountNo{
                            print("user token : \(token)")
                            UserDefaults.standard.set("\(token)", forKey: "UserToken")
                            UserDefaults.standard.set("\(usernameLoggedIn)", forKey: "Username")
                            UserDefaults.standard.set("\(accountNumber)", forKey: "AccountNumber")
                            print("TOKEN SET")
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
