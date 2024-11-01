//
//  ShoesCategoryTableViewCell.swift
//  OrderFoodApp
//
//  Created by Muhammad Farrel Al Fathir on 04/10/24.
//

import UIKit

class ShoesCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryItems: [ShoesCategoryData] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var category: ShoesCategory = .nike
    var onSelectCategory: ((_ category: ShoesCategory) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    func setup() {
        let layout = CustomLayoutCollectionView()
        collectionView.collectionViewLayout = layout
                
        let nib = UINib(nibName: "ShoesCategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ShoesCategoryCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ShoesCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoesCategoryCollectionViewCell", for: indexPath) as?  ShoesCategoryCollectionViewCell
        cell?.setup(item: categoryItems[indexPath.row].category)

        return cell ?? UICollectionViewCell()

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 3.5) - 10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categoryItems[indexPath.row].category
        onSelectCategory?(selectedCategory)
    }

    
}
