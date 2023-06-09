//
//  Extensions.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 6/5/23.
//

import Foundation
import UIKit


extension UIViewController {
    
    
    func showAlert(title: String?, message: String?, onTap: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction(title: "Okay", style: .default) { _ in
            onTap?()
        })
        
        self.present(alertController, animated: true)
    }
    
    func showConfirmAlert(title: String?, message: String?, button: String, onTap: (()->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alertController.addAction(UIAlertAction(title: button, style: .default) { _ in
            onTap?()
        })
        
        self.present(alertController, animated: true)
    }
}
