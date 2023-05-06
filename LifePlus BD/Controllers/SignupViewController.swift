//
//  SignupViewController.swift
//  LifePlusBD_Assessment
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sign Up"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let username = userNameTF.text, !username.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your username")
            return
        }
        
        guard let name = nameTF.text, !name.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your name")
            return
        }
        
        guard let phone = phoneTF.text, !phone.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your phone")
            return
        }

        guard let password = passwordTF.text, !password.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your password")
            return
        }
        
        let userIserted = DBManager.shared.insertUser(name: name, userName: username, phone: phone, password: password)
      
        if userIserted {
            showAlert(title: "Successful", message: "Your account has been created successfully") {
                print("user created: \(userIserted)")
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            showAlert(title: "Failed", message: "Failed to register your account")
        }
    }
    
    
   
    @IBAction func loginPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


