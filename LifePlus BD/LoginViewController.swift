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

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
  
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let username = userNameTF.text, let password = passwordTF.text else {
            print("enter correctly credentials!")
            return
        }
        let user = DBManager.shared.getUserBy(userName: username)
        if user?.userName == username, user?.password == password {
            print("logged in successfully")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
