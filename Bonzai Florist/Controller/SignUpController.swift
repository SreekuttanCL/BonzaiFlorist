//
//  SignUpController.swift
//  Bonzai Florist
//
//  Created by Sreekuttan C L on 2019-11-29.
//  Copyright © 2019 Sreekuttan C L. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailText.borderStyle = .roundedRect
        password.borderStyle = .roundedRect
        confirmPassword.borderStyle = .roundedRect
        btnSignUp.roundedButton()
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        handleSignUp()
    }
    
    @objc func handleSignUp() {
        guard let email = emailText.text else {
            return
        }

        guard let password = password.text else {
            return
        }

        signUpUser(withEmail: email, password: password)
    }
    
    func signUpUser(withEmail email: String, password: String) {

        if emailText.text == ""{
            let alert = UIAlertController(title: "Error", message: "Email is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Ok" , style: .default, handler: nil))
            self.present(alert, animated: true)
        }

        else if password != confirmPassword.text {
            let alert = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Ok" , style: .default, handler: nil))
            self.present(alert, animated: true)
        }

        else {

            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

                if let error = error {
    
                    print("Failed to sign up user:", error.localizedDescription)
                    return
                }

//                guard let uid = result?.user.uid else { return }
//
//                let values = ["email": email, "username": username]
//
//                Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: {(error, ref) in
//                    if let error = error {
//                        print("Failed to update databse:", error.localizedDescription)
//                        return
//                    }

                    self.performSegue(withIdentifier: "toHome", sender: self)
                    print("Successfully signed up")
               // })
            }
        }
    }
}

