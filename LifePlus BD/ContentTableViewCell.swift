//
//  ContentTableViewCell.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit
import SDWebImage

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tvshowImage: UIImageView!
    @IBOutlet weak var tvshowLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUI(tvshow: TVShow) {
        tvshowLabel.text = tvshow.details?.name
        
        if let urlString = tvshow.imageURL, let url = URL(string: urlString) {
            tvshowImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), context: nil)

        } else {
            tvshowImage.image = UIImage(named: "placeholder")
        }
    }
    
}
