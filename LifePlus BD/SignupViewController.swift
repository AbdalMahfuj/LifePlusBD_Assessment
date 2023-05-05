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
