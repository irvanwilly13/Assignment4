//
//  FoodDetailItemTableViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 01/10/24.
//

import UIKit

class FoodDetailItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    
    var items: [FoodItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var onSelectItems: ((_ category: FoodItem) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let layout = CustomLayoutCollectionView()
        collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "FoodDetailItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FoodDetailItemCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension FoodDetailItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodDetailItemCollectionViewCell", for: indexPath) as?  FoodDetailItemCollectionViewCell
        
        cell?.setup(data: items[indexPath.row])

        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 2) - 10, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectItems?(items[indexPath.row])
    }
    
}
