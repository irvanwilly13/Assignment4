//
//  FoodDetailItemCollectionViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 01/10/24.
//

import UIKit

class FoodDetailItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(data: FoodItem?) {
        guard let data = data else {
            return
        }
        titleLabel.text = data.name
        descriptionLabel.text = data.description
        imgView.image = UIImage(named: data.image)
        ratingLabel.text = String(data.rating)
        starImage.image = UIImage(systemName: data .isFavorite ? "star.fill" : "star")
        favoriteImage.image = UIImage(systemName: data.isFavorite ? "heart.fill" : "heart")

    }
}
