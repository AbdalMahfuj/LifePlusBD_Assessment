//
//  LoginViewController.swift
//  LifePlusBD_Assessment
//
//  Created by MAHFUJ on 4/5/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var registerPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
  


    @IBAction func registerPressed(_ sender: UIButton) {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
