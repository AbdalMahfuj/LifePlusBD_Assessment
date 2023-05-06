//
//  ProfileViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit

class ProfileViewController: UIViewController {

    private var user: User?
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var innerNameView: UIView!
    @IBOutlet weak var innerUsernameView: UIView!
    @IBOutlet weak var innerPhoneView: UIView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    class func initVC(user: User)->ProfileViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.user = user
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"

        nameLabel.text = "\(user?.name ?? "Name not found")"
        usernameLabel.text = "\(user?.userName ?? "Username not found")"
        phoneLabel.text = "\(user?.phone ?? "Phone not found")"
        
        designUIView(outView: nameView, innerView: innerNameView)
        designUIView(outView: userNameView, innerView: innerUsernameView)
        designUIView(outView: phoneView, innerView: innerPhoneView)
    }
    
}


extension ProfileViewController {
    private func designUIView(outView: UIView, innerView: UIView) {
        outView.layer.borderWidth = 1
        outView.layer.borderColor = UIColor.lightGray.cgColor
        outView.layer.cornerRadius = 5
        
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.systemGray2.cgColor
        innerView.layer.cornerRadius = 10
    }
}
