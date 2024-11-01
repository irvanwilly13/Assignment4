//
//  FoodCategoryCollectionViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 01/10/24.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(item: FoodCategory) {
        imgView.image = UIImage(named: item.setImage())
        categoryLabel.text = item.rawValue
    }

}
