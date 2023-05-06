//
//  LoginViewController.swift
//  LifePlusBD_Assessment
//
//  Created by MAHFUJ on 4/5/23.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var logoImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
        logoImageview.layer.cornerRadius = 20


    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
  
    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let username = userNameTF.text, !username.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your username")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            showAlert(title: "Caution", message: "Please enter your password")
            return
        }
        

        if let user = DBManager.shared.getUserBy(userName: username, password: password) {
            print("logged in successfully")
            UserDefaults.standard.set(username, forKey: "user_name")
            UserDefaults.standard.synchronize()
            let dashboardVC = DashboardViewController.initVC(user: user)
            navigationController?.pushViewController(dashboardVC, animated: true)
        } else {
            showAlert(title: "Login Failed", message: "Enter credential correctly!")
        }
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}


