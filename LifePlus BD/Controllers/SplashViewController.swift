//
//  SplashViewController.swift
//  LifePlusBD_Assessment
//
//  Created by MAHFUJ on 4/5/23.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var splashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "hello"
        splashLabel.text = ""
        printStringWithDelay(string: "⚡️Hey! Welcome To LifePlus BD.")
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    ///
    private func printStringWithDelay(string: String) {
        var index = string.startIndex
      
        Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { (timer) in
            self.splashLabel.text?.append(string[index])

            index = string.index(after: index)
            
            if index == string.endIndex {
                timer.invalidate()
                self.gotoLanding()
            }
        }
    }
    
    
    private func gotoLanding() {
        if let username = UserDefaults.standard.string(forKey: "user_name") {
            if let user = DBManager.shared.getUserBy(userName: username) {
                print("logged in successfully")
                let dashboardVC = DashboardViewController.initVC(user: user)
                navigationController?.pushViewController(dashboardVC, animated: true)
            } else {
                gotoLogin()
            }
        } else {
           gotoLogin()
        }   
    }
    func gotoLogin() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
