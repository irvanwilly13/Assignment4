//
//  AdsTableViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 03/10/24.
//

import UIKit

class AdsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adsImg: UIImageView!
    @IBOutlet weak var adsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(data: AdsFoodData?) {
        guard let data = data else {
            return
        }
        adsImg.image = UIImage(named: data.image)
        adsLabel.text = data.name
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
