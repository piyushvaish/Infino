//
//  LoginViewController.swift
//  Infino
//
//  Created by Piyush Vaish on 18/06/19.
//  Copyright © 2019 Piyush Vaish. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController{
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldUsername: UITextField!
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        let (isLoginDetailValid,login) = isValid()
        if isLoginDetailValid{
            let parameters = ["username":login?.username,"password":login?.password]
            guard let url = URL(string: URLConstants.postCredentials) else{
                return
            }
            
            WebService().postLoginCredentials(url: url, parameters: parameters as! [String:String]) {[unowned self] (loginResponse) in
                print(loginResponse.id)
                print(loginResponse.username)
                print(loginResponse.password)
                UserDefaults.standard.set(loginResponse.id, forKey: "UserID")
                //let saveSuccessful:Bool = KeychainWrapper.standard.set(loginResponse.id, forKey: "c")
                //Move to HomePage
               // let abc = KeychainWrapper.standard.string(forKey: "UserID")
                DispatchQueue.main.async {
                   
                    self.performSegue(withIdentifier: SegueIdentifiers.showHomePage, sender: nil)
                }
                
            }
        }
    }
    
    private func isValid()->(Bool,Login?){
        
        guard let password = txtFieldPassword.text, let username = txtFieldUsername.text else{
            return (false,nil)
        }
        if password.isEmpty || username.isEmpty{
            return (false,nil)
        }
        let login = Login(username: username, password: password)
        return (true,login)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showHomePage{
            let homePageViewController = segue.destination as! HomePageViewController
            homePageViewController.title = "Home"
        }
    }
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag{
        case TextfieldType.usernameTextField.rawValue:
            txtFieldUsername.text = textField.text
        case TextfieldType.passwordTextField.rawValue:
            txtFieldPassword.text = textField.text
        default:
            print("No Default Case")
        }
    }
}

enum TextfieldType:Int {
    case usernameTextField = 0
    case passwordTextField
}
