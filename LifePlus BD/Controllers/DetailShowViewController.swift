//
//  DetailShowViewController.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 6/5/23.
//

import UIKit
import SDWebImage

class DetailShowViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var result:TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI(tvshow: result!)
    }
    
    class func initVC(result: TVShow)->DetailShowViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "DetailShowViewController") as! DetailShowViewController
        vc.result = result
        return vc
    }
    
    
    func setUI(tvshow: TVShow) {
        titleLabel.text = "Title: \(tvshow.details?.name ?? "N/A")"
        ratingLabel.text = "Rating: \(tvshow.details?.rating?.average ?? 0.0)"
        runtimeLabel.text = "Runtime: \(tvshow.details?.runtime ?? 0.0)"
        languageLabel.text = "Language: \(tvshow.details?.language ?? "N/A")"
        
        if let desc = tvshow.details?.summary, desc.count > 0 {
            if let attributedString = try? NSAttributedString(data: Data(desc.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                descriptionLabel.text = "Summary: \(attributedString.string)"
            }
        }
       
        
        if let urlString = tvshow.imageURL, let url = URL(string: urlString) {
            detailImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), context: nil)
        } else {
            detailImage.image = UIImage(named: "placeholder")
        }
    }
    
}
