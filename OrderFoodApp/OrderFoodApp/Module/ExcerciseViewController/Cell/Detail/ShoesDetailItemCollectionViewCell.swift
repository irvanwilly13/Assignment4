//
//  ShoesDetailItemCollectionViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

class ShoesDetailItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImg: UIImageView!
    @IBOutlet weak var favoriteImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup(data: ShoesItem?) {
        guard let data = data else {
            return
        }
        nameLabel.text = data.name
        descriptionLabel.text = data.description
        imgView.image = UIImage(named: data.image)
        ratingLabel.text = String(data.rating)
        ratingImg.image = UIImage(systemName: data .isFavorite ? "star.fill" : "star")
        favoriteImg.image = UIImage(systemName: data.isFavorite ? "heart.fill" : "heart")

    }

}
