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
      //  tvshowLabel.text = tvshow.details?.name
        titleLabel.text = tvshow.details?.name
        descriptionLabel.text = tvshow.details?.type
        ratingLabel.text = "\(tvshow.details?.rating?.average ?? 0.0)"
        runtimeLabel.text = tvshow.details?.language
        if let urlString = tvshow.imageURL, let url = URL(string: urlString) {
            detailImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), context: nil)
        } else {
            detailImage.image = UIImage(named: "placeholder")
        }
    }

}
