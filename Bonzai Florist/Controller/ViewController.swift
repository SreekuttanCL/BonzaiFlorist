//
//  ViewController.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-23.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailText.borderStyle = .roundedRect
        password.borderStyle = .roundedRect
        btnLogin.roundedButton()
        
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        handleLogin()
    }
    
    @objc func handleLogin() {
        guard let email = emailText.text else {
            return
        }
        
        guard let password = password.text else {
            return
        }
        
        loginUser(withEmail: email, password: password)
    }
    
    
    func loginUser(withEmail email: String, password: String) {
        
        if email == "" && password == "" {
            let alert = UIAlertController(title: "Error", message: "Username or password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "Invalid Username or Password", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title:"Cancel" , style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    print("Failed to Log In user:", error.localizedDescription)
                    return
                }
                else {
                    self.performSegue(withIdentifier: "toHome", sender: self)
                    print("successfully logged in..")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

