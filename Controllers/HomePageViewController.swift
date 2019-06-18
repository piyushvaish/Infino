//
//  HomePageViewController.swift
//  Infino
//
//  Created by Piyush Vaish on 18/06/19.
//  Copyright © 2019 Piyush Vaish. All rights reserved.
//

import Foundation
import UIKit

class HomePageViewController:UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: ResponseKeys.userID)
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
    }
}
