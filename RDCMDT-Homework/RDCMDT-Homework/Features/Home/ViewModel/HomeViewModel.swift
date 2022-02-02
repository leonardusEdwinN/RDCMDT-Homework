//
//  HomeViewModel.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation

class HomeViewModel{
    private var transactionsResponseVM = [TransactionViewModel]()
    
    func getBalance(completion: @escaping (String, Balance) -> Void) {
        let token = UserDefaults.standard.string(forKey: "UserToken")
        
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/balance"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(Balance.self, from: postResult)
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion(errorMessage, Balance())
                        }
                    }else if (dataDecoder.status == "success"){
                        completion(dataDecoder.status, dataDecoder)
                        
                    }
                    
                  } catch let parsingError {
                      
                     print("Error", parsingError)
                      completion("\(parsingError)", Balance())
                }
            }
        }
        
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return transactionsResponseVM.count
    }
    
    func modelAt(_ index: Int) -> TransactionViewModel {
        return transactionsResponseVM[index]
    }
    
    func getAllTransactions(completion: @escaping (String, [TransactionViewModel]) -> Void){
        let token = UserDefaults.standard.string(forKey: "UserToken")
        
        var urlRequest = URLRequest(url:  Constants.Urls.baseURLWithParam(params: "/transactions"))
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "GET"
        
        Webservice().loadPOST(resource: urlRequest) { (result) in
            
            if let postResult = result {
                do{
                    let dataDecoder = try JSONDecoder().decode(TransactionsResponse.self, from: postResult)
                    
                    if(dataDecoder.status == "failed"){
                        if let errorMessage = dataDecoder.error{
                            completion(errorMessage, [])
                        }
                    }else if (dataDecoder.status == "success"){
                        if let dataResponse = dataDecoder.data{
                            for data in dataResponse {
                                
                                self.transactionsResponseVM.append(TransactionViewModel(data: data))
                            }
                            
                            
                            
                        }
                        
                        
                        completion(dataDecoder.status ?? "", self.transactionsResponseVM)
                        
                    }
                    
                  } catch let parsingError {
                      
                     print("Error", parsingError)
                      completion("\(parsingError)", [])
                }
            }
        }
    }
}

class TransactionViewModel{
    let item: DataTransaction

    init(data: DataTransaction) {
        self.item = data
    }
}
