//
//  DashboardViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var profileButton: UIButton!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Dashboard"

            self.profileButton.setTitle(self.user?.userName, for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    class func initVC(user: User)->DashboardViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.user = user
        return vc
    }
    
    
}
