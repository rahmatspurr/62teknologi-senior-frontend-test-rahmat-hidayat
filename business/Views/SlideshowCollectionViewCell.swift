//
//  SlideshowCollectionViewCell.swift
//  business
//
//  Created by Rahmat Hidayat on 12/12/22.
//

import UIKit

class SlideshowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = R.image.ic_shop_banner_placeholder()
    }
    
    func setupCell(_ photoUrl: String?) {
        if let photoUrl = photoUrl {
            self.photoImageView.setImage(url: photoUrl, placeholder: R.image.ic_shop_banner_placeholder())
        }else{
            self.photoImageView.image = R.image.ic_shop_banner_placeholder()
        }
    }

}
