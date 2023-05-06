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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let usernameEntered = userNameTF.text, !usernameEntered.isEmpty else {
            openAlert(message: "Please enter your username")
            return
        }
        guard let nameEntered = nameTF.text, !nameEntered.isEmpty else {
            openAlert(message: "Please enter your name")
            return
        }
        guard let phoneEntered = phoneTF.text, !phoneEntered.isEmpty else {
            openAlert(message: "Please enter your phone")
            return
        }

        guard let passwordEntered = passwordTF.text, !passwordEntered.isEmpty else {
            openAlert(message: "Please enter your password")
            return
        }
        
        guard let name = nameTF.text, let username = userNameTF.text, let phone = phoneTF.text, let password = passwordTF.text else {
            print("Enter all fields")
            return
        }
        let userIserted = DBManager.shared.insertUser(name: name, userName: username, phone: phone, password: password)
        print("user created: \(userIserted)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


extension SignupViewController {
    func openAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        present(alertController, animated: true)
    }
}
