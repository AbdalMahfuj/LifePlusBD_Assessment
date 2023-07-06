//
//  ContentTableViewCell.swift
//  LifePlus BD
//
//  Created by MAHFUJ on 5/5/23.
//

import UIKit
import SDWebImage
import SkeletonView


class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var tvshowImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // fullView.showAnimatedSkeleton()
        nameLabel.showAnimatedSkeleton()
        scoreLabel.showAnimatedSkeleton()
        runtimeLabel.showAnimatedSkeleton()
        tvshowImage.showAnimatedSkeleton()
        
        tvshowImage.layer.cornerRadius = 8.0
        tvshowImage.clipsToBounds = true
    }
    
    func hideSkeletonAnimatio() {
       // fullView.hideSkeleton()
        nameLabel.hideSkeleton()
        scoreLabel.hideSkeleton()
        runtimeLabel.hideSkeleton()
        tvshowImage.hideSkeleton()
    }
    
    func setUI(tvshow: TVShow) {
        nameLabel.text = tvshow.details?.name
        scoreLabel.text = "Score: " + String(format: "%0.2f", tvshow.score ?? 0.0)
        runtimeLabel.text = "Runtime: \(tvshow.details?.runtime ?? 0.0) m"
        if let urlString = tvshow.imageURL, let url = URL(string: urlString) {
            tvshowImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), context: nil)
        } else {
            tvshowImage.image = UIImage(named: "placeholder")
        }
    }
    
}
