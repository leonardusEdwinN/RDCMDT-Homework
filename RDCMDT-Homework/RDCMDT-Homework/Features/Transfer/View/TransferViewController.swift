//
//  TransferViewController.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation
import UIKit

protocol TransferMoneyProtocol {
    func transferMoneyAndReloadData(accountHolder: String, amount : Double)
}

class TransferViewController : UIViewController{
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var payessLabel: UILabel!
    @IBOutlet weak var payessTextfield: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    @IBAction func transferButtonPressed(_ sender: Any) {
        var accountNumber = ""
        var accountHolder = ""
        
        
        if payessTextfield.text == "" && amountTextfield.text == ""{
            labelErrorMessage.isHidden = true
            labelErrorMessage.text = "Please select payess and input amount"
        }else{
            if let splitAccountNumber = payessTextfield.text?.split(separator: "_"){
                accountNumber = String(splitAccountNumber[0])
                accountHolder = String(splitAccountNumber[1])
            }
            print("account NUmber \(accountNumber)::\(accountNumber.count) :: \(accountHolder)")
            
            if let amount = amountTextfield.text{
                transferMoney(accountNumber: accountNumber, amount: Double(amount) ?? 0.0, description: descriptionTextfield.text ?? "", accountHolder :accountHolder)
            }
        }
    }
    @IBOutlet weak var transferButton: UIButton!
    
    
    let payessPickerView = UIPickerView()
    var transferVM = TransferViewModel()
    var delegate : TransferMoneyProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getDataPayess()
        hideKeyboardWhenTappedAround()
        registerPickerView()
        
        
    }
    
    
    func registerPickerView(){
        
        payessPickerView.delegate = self
        payessPickerView.dataSource = self
        payessTextfield.inputView = payessPickerView
    }
    
    func getDataPayess() {
        LoadingScreen.sharedInstance.showIndicator()
        transferVM.getPayess { status, payess in
            if(status == "success"){
                
                DispatchQueue.main.async {
                    LoadingScreen.sharedInstance.hideIndicator()
                    self.labelErrorMessage.isHidden = true
                    self.payessPickerView.reloadAllComponents()
                }
            }else{
                LoadingScreen.sharedInstance.hideIndicator()
                self.labelErrorMessage.isHidden = false
                self.labelErrorMessage.text = "ERROR"
            }
        }
    }
    
    func transferMoney(accountNumber: String, amount: Double, description : String, accountHolder : String){
        LoadingScreen.sharedInstance.showIndicator()
        
        print("TRANSFER AMMOUNT : \(amount)")
        transferVM.transferMoney(accountNumber: accountNumber, amount: amount, description: description) { status, message in
            if(status == "ERROR"){
                LoadingScreen.sharedInstance.hideIndicator()
                self.labelErrorMessage.isHidden = false
                self.labelErrorMessage.text = message
            }else{
                self.dismiss(animated: true) { [self] in
                    print("SUCCESS TRANSFER : \(message)")
                    self.labelErrorMessage.isHidden = true
                    LoadingScreen.sharedInstance.hideIndicator()
                    self.delegate?.transferMoneyAndReloadData(accountHolder:  accountHolder, amount: amount)
                }
            }
        }
       
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(TransferViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpUI(){
        labelErrorMessage.isHidden = true
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
        
        
        transferButton.layer.cornerRadius = 15
        transferButton.layer.borderColor = UIColor.red.cgColor
        transferButton.layer.borderWidth = 2
        
    }
}

extension TransferViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transferVM.numberOfRows()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let data = transferVM.modelAt(row)
        
        
        if let accountNumber = data.accountNo, let accountHolder = data.name{
            return "\(accountNumber) _ \(accountHolder)"
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = transferVM.modelAt(row)
        
        if let accountNumber = data.accountNo, let accountHolder = data.name{
            payessTextfield.text = "\(accountNumber)_\(accountHolder)"
        }
        
        self.view.endEditing(true)
        
    }
    
    
}
