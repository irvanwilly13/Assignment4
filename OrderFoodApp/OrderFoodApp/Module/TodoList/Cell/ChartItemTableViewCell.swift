//
//  ChartItemTableViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 02/10/24.
//

import UIKit

class ChartItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(data: ProfileData?) {
        guard let data = data else { return }
        self.nameLabel.text = "Nama: \(data.name)"
        self.ageLabel.text = "age: \(data.age)"
        self.statusLabel.text = "status: \(data.status)"
        self.imgView.image = UIImage(named: "onBoard-3")
        
    }
}
