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
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var innerNameView: UIView!
    @IBOutlet weak var InnerPhoneView: UIView!
    @IBOutlet weak var InnerUsernameView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Name: \(user?.name ?? "Name not found")"
        usernameLabel.text = "Username: \(user?.userName ?? "Username not found")"
        phoneLabel.text = "Phone: \(user?.phone ?? "Phone not found")"
        
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.systemGreen.cgColor
        nameView.layer.cornerRadius = 5
        
        userNameView.layer.borderWidth = 1
        userNameView.layer.borderColor = UIColor.systemGreen.cgColor
        userNameView.layer.cornerRadius = 5
        
        phoneView.layer.borderWidth = 1
        phoneView.layer.borderColor = UIColor.systemGreen.cgColor
        phoneView.layer.cornerRadius = 5
        
        innerNameView.layer.borderWidth = 1
        innerNameView.layer.borderColor = UIColor.systemGray2.cgColor
        innerNameView.layer.cornerRadius = 10
        
        InnerPhoneView.layer.borderWidth = 1
        InnerPhoneView.layer.borderColor = UIColor.systemGray2.cgColor
        InnerPhoneView.layer.cornerRadius = 10
        
        InnerUsernameView.layer.borderWidth = 1
        InnerUsernameView.layer.borderColor = UIColor.systemGray2.cgColor
        InnerUsernameView.layer.cornerRadius = 10
        
        
        
        
        
        
    }
    

    class func initVC(user: User)->ProfileViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.user = user
        return vc
    }

}
