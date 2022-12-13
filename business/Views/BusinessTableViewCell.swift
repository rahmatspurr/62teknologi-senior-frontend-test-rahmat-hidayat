//
//  BusinessTableViewCell.swift
//  business
//
//  Created by Rahmat Hidayat on 10/12/22.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.businessImageView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.businessImageView.image = R.image.ic_shop_placeholder()
    }
    
    func setupCell(_ business: Businesses) {
        if let imageUrl = business.imageURL {
            self.businessImageView.setImage(url: imageUrl, placeholder: R.image.ic_shop_placeholder())
        }else{
            self.businessImageView.image = R.image.ic_shop_placeholder()
        }
        
        self.nameLabel.text = business.name
        
        let rating = "\(business.rating ?? 0) (\(business.reviewCount ?? 0) Reviews)"
        self.ratingLabel.text = rating
        
        let address = business.location?.displayAddress?.joined(separator: ", ")
        self.addressLabel.text = address
    }
    
}
