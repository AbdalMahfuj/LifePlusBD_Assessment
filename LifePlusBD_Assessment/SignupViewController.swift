//
//  SignupViewController.swift
//  LifePlusBD_Assessment
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
