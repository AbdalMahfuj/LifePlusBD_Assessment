//
//  ProfileViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User?
    
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Name: \(user?.name ?? "Name not found")"
        usernameLabel.text = "Username: \(user?.userName ?? "Username not found")"
        phoneLabel.text = "Phone: \(user?.phone ?? "Phone not found")"
    }
    

    class func initVC(user: User)->ProfileViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.user = user
        return vc
    }

}
