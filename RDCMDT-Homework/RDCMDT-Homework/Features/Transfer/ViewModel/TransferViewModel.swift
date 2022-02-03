//
//  TransferViewModel.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 03/02/22.
//

import Foundation

class TransferViewModel{
    private var payess = [DataPayess]()
    
    func getPayess(completion: @escaping (String, [DataPayess]) -> Void){
        let token = UserDefaults.standard.string(forKey: "UserToken")
        
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/payees"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(PayessResponse.self, from: postResult)
                    
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion(errorMessage, [])
                        }
                    }else if (dataDecoder.status == "success"){
                        if let dataResponse = dataDecoder.data{
                            for data in dataResponse {
                                
                                self.payess.append(data)
                            }
                        }
                        completion(dataDecoder.status ?? "", self.payess)
                        
                    }
                    
                  } catch let parsingError {
                      
                     print("Error", parsingError)
                      completion("\(parsingError)", [])
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        return payess.count
    }
    
    func modelAt(_ index: Int) -> DataPayess {
        return payess[index]
    }
    
    
    func transferMoney(accountNumber: String, amount : Double, description : String, completion: @escaping (String, String) -> Void) {
        let json: [String: Any] = ["receipientAccountNo": accountNumber,
                                   "amount": amount,
                                   "description": description]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        print("JSON DATA : \(jsonData)")
        
        let token = UserDefaults.standard.string(forKey: "UserToken")
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/transfer"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(TransferModel.self, from: postResult)
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion("ERROR", errorMessage)
                        }
                    }else if (dataDecoder.status == "success"){
                        if let transactionId = dataDecoder.transactionId{
                            completion("SUCCESS", transactionId)
                        }
                    }
                    
                  } catch let parsingError {
                      completion("ERROR", "\(parsingError)")
                }
            }
        }
        
    }
    
}
