//
//  RegisterViewController.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 31/01/22.
//

import Foundation
import UIKit

class RegisterViewController : UIViewController{
    // MARK: Variable
    
    var registerVM = RegisterViewModel()
    
    // MARK: UIComponent
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmTextfield: UITextField!
    @IBOutlet weak var registerErrorMessageLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        
        
        if confirmTextfield.text != "" && passwordTextfield.text != ""{
            if let confirmPassword = confirmTextfield.text, let password = passwordTextfield.text{
                
                if confirmPassword.count > 7 && password.count > 7{
                    print("CONFIRM : \(confirmPassword) :: \(password)")
                    if(confirmPassword == password){
                        //cek baru usernamenya
                        if usernameTextfield.text != ""{
                            if let username = usernameTextfield.text {
                                print("username : \(username)")
                                //coba register dari sini
                                LoadingScreen.sharedInstance.showIndicator()
                                
                                registerVM.registerNewUser(username: username, password: password) { status, message in
                                    
                                    if(status == "SUCCESS"){
                                        self.registerErrorMessageLabel.isHidden = true
                                        LoadingScreen.sharedInstance.hideIndicator()
                                        self.dismiss(animated: false, completion: nil)
                                    }else if(status == "ERROR"){
                                        LoadingScreen.sharedInstance.hideIndicator()
                                        self.registerErrorMessageLabel.isHidden = false
                                        self.registerErrorMessageLabel.text = "\(message)"
                                    }
                                    
                                }
                            }
                        }
                        else{
                            registerErrorMessageLabel.isHidden = false
                            registerErrorMessageLabel.text = "Please input username"
                        }
                    }else{
                        registerErrorMessageLabel.isHidden = false
                        registerErrorMessageLabel.text = "Your password and confirm password doesn't match"
                    }
                }else{
                    registerErrorMessageLabel.isHidden = false
                    registerErrorMessageLabel.text = "Password and Confirm password must be more than 8 characters"
                }
            }
            
        }else{
            registerErrorMessageLabel.isHidden = false
            registerErrorMessageLabel.text = "Please input username, password, and confirm password"
        }
    }
    
    func setupUI(){
        self.registerErrorMessageLabel.isHidden = true
        passwordTextfield.isSecureTextEntry = true
        confirmTextfield.isSecureTextEntry = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
}
