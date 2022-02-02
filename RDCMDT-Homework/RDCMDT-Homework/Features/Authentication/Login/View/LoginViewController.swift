//
//  LoginViewController.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 30/01/22.
//

import Foundation
import UIKit

class LoginViewController : UIViewController{
    
    // MARK: Variable
    var loginVM = LoginViewModel()
    
    // MARK: UI Component
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet var usernameLabel: UIView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var loginErrorMessage: UILabel!
    
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func registerButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToRegister", sender: LoginViewController.self)
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if passwordTextfield.text != "" && usernameTextfield.text != ""{
            
            if let username = usernameTextfield.text, let password = passwordTextfield.text {
                print("username : \(username)")
                LoadingScreen.sharedInstance.showIndicator()
                
                loginVM.login(username: username, password: password) { status, message in
                    if(status == "SUCCESS"){
                        self.loginErrorMessage.isHidden = true
                        LoadingScreen.sharedInstance.hideIndicator()
                        
                        //masuk ke new controller :
                        print("SUCCESS LOGIN")
                    }else if(status == "ERROR"){
                        LoadingScreen.sharedInstance.hideIndicator()
                        self.loginErrorMessage.isHidden = false
                        self.loginErrorMessage.text = "\(message)"
                    }
                }
            }
            
            
        }else{
            loginErrorMessage.isHidden = false
            loginErrorMessage.text = "Please input username and password"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.loginErrorMessage.isHidden = true
        self.passwordTextfield.isSecureTextEntry = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRegister"{
            if let destVC = segue.destination as? RegisterViewController {
                destVC.modalPresentationStyle = .fullScreen
            }
        }
    }
}
