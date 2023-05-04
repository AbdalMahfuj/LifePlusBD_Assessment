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
        
        splashLabel.text = ""
        printStringWithDelay(string: "⚡️Hey! Welcome To LifePlus BD.")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                // Perform segue to SecondViewController
//                self.performSegue(withIdentifier: "SplashToRegVC", sender: self)
//        }
        
        
        /*
        var users = DBManager.shared.getAllUsers()
        print("count -1 \(users.count)")
        
        let inserted = DBManager.shared.insertUser(name: "x", userName: "u-x", phone: "1", password: "")
        print("inserted \(inserted)")

        users = DBManager.shared.getAllUsers()
        print("count -2 \(users.count)")
        
        let updated = DBManager.shared.updateUser(name: "x2", userName: "u-x", phone: "11", password: "")
        print("updated \(updated)")

        users = DBManager.shared.getAllUsers()
        print("count -2 \(users.count)")
        */
    }
    
  
    
    private func printStringWithDelay(string: String) {
        var index = string.startIndex
      
        Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { (timer) in
            self.splashLabel.text?.append(string[index])

            index = string.index(after: index)
            
            if index == string.endIndex {
                timer.invalidate()
                self.gotoLanding()
             //   self.performSegue(withIdentifier: "SplashToRegVC", sender: self)
            }
        }
    }
    
    
    private func gotoLanding(){
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
