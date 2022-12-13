//
//  ReviewTableViewCell.swift
//  business
//
//  Created by Rahmat Hidayat on 12/12/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.image = R.image.ic_user_placeholder()
    }
    
    func setupCell(_ review: Review) {
        guard let user = review.user else { return }
        
        if let imageUrl = user.imageUrl {
            self.profileImageView.setImage(url: imageUrl, placeholder: R.image.ic_user_placeholder())
        }else{
            self.profileImageView.image = R.image.ic_user_placeholder()
        }
        
        self.nameLabel.text = user.name
        self.ratingLabel.text = "\(review.rating ?? 0)"
        self.dateTimeLabel.text = review.timeCreated?.dateRelativeFormatting()
        self.commentLabel.text = review.text        
    }
}
