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
        printStringWithDelay(string: "⚡️Hey! Welcome To Our System.")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                // Perform segue to SecondViewController
//                self.performSegue(withIdentifier: "SplashToRegVC", sender: self)
//        }
    }
    
  
    
    private func printStringWithDelay(string: String) {
        var index = string.startIndex
      
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { (timer) in
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
