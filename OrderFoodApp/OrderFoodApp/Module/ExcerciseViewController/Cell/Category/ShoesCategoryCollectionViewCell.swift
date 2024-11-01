//
//  ShoesCategoryCollectionViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

class ShoesCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(item: ShoesCategory) {
        imgView.image = UIImage(named: item.setImage())
        labelView.text = item.rawValue
    }

}
