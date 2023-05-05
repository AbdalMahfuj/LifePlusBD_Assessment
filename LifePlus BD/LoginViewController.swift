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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
  
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let username = userNameTF.text, let password = passwordTF.text else {
            print("enter correctly credentials!")
            return
        }
        if username.isEmpty {
            
            return
        }
        if let user = DBManager.shared.getUserBy(userName: username, password: password) {
            print("logged in successfully")
            UserDefaults.standard.set(username, forKey: "user_name")
            UserDefaults.standard.synchronize()
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            let dashboardVC = DashboardViewController.initVC(user: user)
            navigationController?.pushViewController(dashboardVC, animated: true)
        } else {
            
        }
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
