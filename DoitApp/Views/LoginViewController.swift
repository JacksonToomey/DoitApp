//
//  ViewController.swift
//  DoitApp
//
//  Created by Jackson Toomey on 10/28/18.
//  Copyright © 2018 Jackson Toomey. All rights reserved.
//

import UIKit
import CoreData
import os.log

class LoginViewController: UIViewController, UITextFieldDelegate {
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Private Properties
    var loginData: AuthProvider.LoginData = AuthProvider.LoginData(email: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        if AuthProvider.hasUser() {
            loginUser(AuthProvider.getUser()!)
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === emailTextField {
            loginData.email = textField.text ?? ""
        }

        if textField === passwordTextField {
            loginData.password = textField.text ?? ""
        }
    }
    
    //MARK: Actions
    @IBAction func onLoginPress(_ sender: UIButton) {
        let hasVal = {(s: String) -> Bool in
            return s.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) != ""
        }
        if !hasVal(loginData.email) {
            os_log("No Email")
            return
        }
        
        if !hasVal(loginData.password) {
            os_log("No Password")
            return
        }
        loginUser(loginData)
    }
    
    private func loginUser(_ loginData: AuthProvider.LoginData) {
        os_log("Logging In")
        AuthProvider.loginUser(loginData, completion: {token in
            os_log("Log In Success")
            let navController = self.storyboard?.instantiateViewController(withIdentifier: "basenav") as! UINavigationController
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.4, options: UIView.AnimationOptions.transitionFlipFromRight, animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                UIApplication.shared.keyWindow?.rootViewController = navController
                UIView.setAnimationsEnabled(oldState)
            })
        })
    }
}

